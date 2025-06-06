import 'package:flutter/material.dart';
import 'dart:math';
import '../models/flashcard.dart';
import '../widgets/flip_card.dart';

class StudyScreen extends StatefulWidget {
  final List<Flashcard> flashcards;
  final VoidCallback onBack;

  const StudyScreen({
    Key? key,
    required this.flashcards,
    required this.onBack,
  }) : super(key: key);

  @override
  _StudyScreenState createState() => _StudyScreenState();
}

class _StudyScreenState extends State<StudyScreen> {
  Flashcard? currentFlashcard;
  int currentIndex = 0; // Ajout d'un index pour éviter les calculs avec indexOf
  final Random _random = Random();
  Key flipCardKey = UniqueKey(); // Clé pour forcer le reset de la FlipCard

  @override
  void initState() {
    super.initState();
    _loadRandomFlashcard();
  }

  void _loadRandomFlashcard() {
    if (widget.flashcards.isNotEmpty) {
      int newIndex;
      
      // S'assurer que la nouvelle flashcard est différente de l'actuelle
      if (widget.flashcards.length > 1 && currentFlashcard != null) {
        do {
          newIndex = _random.nextInt(widget.flashcards.length);
        } while (newIndex == currentIndex);
      } else {
        newIndex = _random.nextInt(widget.flashcards.length);
      }
      
      setState(() {
        currentIndex = newIndex;
        currentFlashcard = widget.flashcards[currentIndex];
        flipCardKey = UniqueKey(); // Nouvelle clé pour reset la FlipCard
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Structure principale de l'écran d'étude
    return Scaffold(
      // Barre d'application avec titre et actions
      appBar: AppBar(
        title: Text('Étudier'),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: widget.onBack,
        ),
        actions: [
          if (widget.flashcards.isNotEmpty)
            IconButton(
              icon: Icon(Icons.shuffle),
              onPressed: _loadRandomFlashcard,
              tooltip: 'Nouvelle flashcard',
            ),
        ],
      ),
      // Corps de l'écran avec dégradé de fond
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.orange.shade50, Colors.white],
          ),
        ),
        child: widget.flashcards.isEmpty ? _buildEmptyState() : _buildStudyView(),
      ),
    );
  }

  // Widget affiché quand aucune flashcard n'est disponible
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Icône d'état vide
          Icon(
            Icons.inventory_2_outlined,
            size: 80,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 20),
          // Message principal d'état vide
          const Text(
            'Aucune flashcard disponible',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 10),
          // Message explicatif
          const Text(
            'Créez votre première flashcard pour commencer à étudier',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),
          // Bouton pour retourner créer une flashcard
          ElevatedButton.icon(
            onPressed: widget.onBack,
            icon: Icon(Icons.add),
            label: const Text('Créer une flashcard'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget principal pour l'affichage des flashcards
  Widget _buildStudyView() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const SizedBox(height: 20),
          // Indicateur de progression (numéro de flashcard)
          if (currentFlashcard != null)
            Text(
              'Flashcard ${currentIndex + 1} sur ${widget.flashcards.length}',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w500,
              ),
            ),
          const SizedBox(height: 20),
          // Zone principale d'affichage de la flashcard
          Expanded(
            child: Center(
              child: currentFlashcard != null
                  ? FlipCard(
                      key: flipCardKey, // Clé unique pour forcer le reset
                      front: currentFlashcard!.front,
                      back: currentFlashcard!.back,
                    )
                  : CircularProgressIndicator(), // Widget de chargement si currentFlashcard est null
            ),
          ),
          const SizedBox(height: 20),
          // Bouton pour charger une nouvelle flashcard aléatoire
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton.icon(
              onPressed: _loadRandomFlashcard,
              icon: Icon(Icons.shuffle),
              label: const Text(
                'Nouvelle flashcard',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 8,
              ),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}