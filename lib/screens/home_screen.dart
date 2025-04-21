import 'package:flutter/material.dart';
import 'deck_selector_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tarot Mini-App')),
      body: const DeckSelectorScreen(),
    );
  }
}
