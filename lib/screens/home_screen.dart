import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final int flashcardsCount;
  final VoidCallback onNavigateToCreate;
  final VoidCallback onNavigateToStudy;

  const HomeScreen({
    Key? key,
    required this.flashcardsCount,
    required this.onNavigateToCreate,
    required this.onNavigateToStudy,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Structure principale de l'écran d'accueil
    return Scaffold(
      // Barre d'application avec titre centré
      appBar: AppBar(
        title: Text('Flashcards'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      // Corps de l'écran avec dégradé de fond
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade50, Colors.white],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icône principale de l'application
              Icon(
                Icons.psychology,
                size: 80,
                color: Colors.blue,
              ),
              const SizedBox(height: 20),
              // Titre principal de l'application
              const Text(
                'Flashcards App',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 10),
              // Compteur de flashcards disponibles
              Text(
                '$flashcardsCount flashcard(s) disponible(s)',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 40),
              // Bouton pour créer une nouvelle flashcard
              _buildMenuButton(
                context,
                'Créer une flashcard',
                Icons.add_circle,
                Colors.green,
                onNavigateToCreate,
              ),
              const SizedBox(height: 20),
              // Bouton pour étudier (conditionnel selon le nombre de flashcards)
              _buildMenuButton(
                context,
                'Étudier',
                Icons.school,
                flashcardsCount > 0 ? Colors.orange : Colors.grey,
                flashcardsCount > 0 ? onNavigateToStudy : null,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget réutilisable pour créer les boutons du menu principal
  Widget _buildMenuButton(
    BuildContext context,
    String text,
    IconData icon,
    Color color,
    VoidCallback? onPressed,
  ) {
    // Bouton avec dimensions fixes et style personnalisé
    return SizedBox(
      width: 250,
      height: 60,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: 24),
        label: Text(
          text,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 8,
          shadowColor: color.withOpacity(0.4),
        ),
      ),
    );
  }
}