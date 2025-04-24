import 'package:flutter/material.dart';
import 'package:tarot_mini_app/models/deck.dart';

class MinorArcanaScreen extends StatelessWidget {
  final Deck deck;
  const MinorArcanaScreen({super.key, required this.deck});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Minor Arcana')),
      body: const Center(child: Text('Minor Arcana Cards')),
    );
  }
}
