import 'package:flutter/material.dart';
import 'models/flashcard.dart';
import 'screens/home_screen.dart';
import 'screens/create_flashcard_screen.dart';
import 'screens/study_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flashcards App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
              home: const FlashcardApp(),
    );
  }
}

class FlashcardApp extends StatefulWidget {
  const FlashcardApp({Key? key}) : super(key: key);

  @override
  _FlashcardAppState createState() => _FlashcardAppState();
}

class _FlashcardAppState extends State<FlashcardApp> {
  List<Flashcard> flashcards = [];
  int currentIndex = 0;

  void addFlashcard(Flashcard flashcard) {
    setState(() {
      flashcards.add(flashcard);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: [
          HomeScreen(
            flashcardsCount: flashcards.length,
            onNavigateToCreate: () => setState(() => currentIndex = 1),
            onNavigateToStudy: () => setState(() => currentIndex = 2),
          ),
          CreateFlashcardScreen(
            onFlashcardCreated: addFlashcard,
            onBack: () => setState(() => currentIndex = 0),
          ),
          StudyScreen(
            flashcards: flashcards,
            onBack: () => setState(() => currentIndex = 0),
          ),
        ],
      ),
    );
  }
}