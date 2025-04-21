import 'package:flutter/material.dart';

class MinorArcanaScreen extends StatelessWidget {
  const MinorArcanaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Minor Arcana')),
      body: const Center(child: Text('Minor Arcana Cards')),
    );
  }
}
