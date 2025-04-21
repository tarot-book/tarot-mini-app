import 'package:flutter/material.dart';
import '../../models/deck.dart';

class DeckDescription extends StatelessWidget {
  final Deck deck;
  final TextAlign textAlign;

  const DeckDescription({
    super.key,
    required this.deck,
    this.textAlign = TextAlign.start,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 600),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              deck.name,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: 8),
            Text(
              deck.description,
              textAlign: textAlign,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
