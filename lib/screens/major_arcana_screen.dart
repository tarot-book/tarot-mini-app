import 'package:flutter/material.dart';

class MajorArcanaScreen extends StatelessWidget {
  const MajorArcanaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Major Arcana')),
      body: const Center(child: Text('Major Arcana Cards')),
    );
  }
}
