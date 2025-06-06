import 'package:flutter/material.dart';
import '../models/flashcard.dart';

class CreateFlashcardScreen extends StatefulWidget {
  final Function(Flashcard) onFlashcardCreated;
  final VoidCallback onBack;

  const CreateFlashcardScreen({
    Key? key,
    required this.onFlashcardCreated,
    required this.onBack,
  }) : super(key: key);

  @override
  _CreateFlashcardScreenState createState() => _CreateFlashcardScreenState();
}

class _CreateFlashcardScreenState extends State<CreateFlashcardScreen> {
  final TextEditingController _frontController = TextEditingController();
  final TextEditingController _backController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _frontController.dispose();
    _backController.dispose();
    super.dispose();
  }

  void _createFlashcard() {
    if (_formKey.currentState?.validate() == true) {
      final flashcard = Flashcard(
        front: _frontController.text.trim(),
        back: _backController.text.trim(),
      );
      
      widget.onFlashcardCreated(flashcard);
      
      // Afficher un message de confirmation
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Flashcard créée avec succès !'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );
      
      // Vider les champs
      _frontController.clear();
      _backController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    // Structure principale de l'écran avec AppBar
    return Scaffold(
      // Barre d'application avec titre et bouton retour
      appBar: AppBar(
        title: Text('Créer une flashcard'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: widget.onBack,
        ),
      ),
      // Corps de l'écran avec dégradé de fond
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.green.shade50, Colors.white],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),
                // Titre principal de la page
                const Text(
                  'Nouvelle flashcard',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                // Carte pour le recto de la flashcard
                _buildCard(
                  'Recto',
                  _frontController,
                  'Entrez le texte du recto...',
                  Colors.blue.shade100,
                ),
                const SizedBox(height: 20),
                // Carte pour le verso de la flashcard
                _buildCard(
                  'Verso',
                  _backController,
                  'Entrez le texte du verso...',
                  Colors.orange.shade100,
                ),
                const SizedBox(height: 40),
                // Bouton de création de la flashcard
                SizedBox(
                  height: 50,
                  child: ElevatedButton.icon(
                    onPressed: _createFlashcard,
                    icon: Icon(Icons.add),
                    label: Text(
                      'Créer la flashcard',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 8,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget réutilisable pour créer une carte de saisie
  Widget _buildCard(
    String title,
    TextEditingController controller,
    String hint,
    Color backgroundColor,
  ) {
    // Carte avec élévation et coins arrondis
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Titre de la carte (Recto/Verso)
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade700,
              ),
            ),
            const SizedBox(height: 10),
            // Champ de saisie de texte avec validation
            TextFormField(
              controller: controller,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: hint,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.all(12),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Ce champ ne peut pas être vide';
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }
}