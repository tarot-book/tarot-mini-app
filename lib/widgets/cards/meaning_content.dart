import 'package:flutter/material.dart';

/// A widget that displays tarot card meaning text in a styled container.
/// Can be used for both straight and reversed meanings.
class MeaningContent extends StatelessWidget {
  final String text;

  const MeaningContent({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }
}
