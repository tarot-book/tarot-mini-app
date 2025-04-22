import 'package:flutter/material.dart';

class MinorArcanaScreen extends StatelessWidget {
  final int deckId;
  const MinorArcanaScreen({super.key, required this.deckId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Minor Arcana')),
      body: const Center(child: Text('Minor Arcana Cards')),
    );
  }
}
