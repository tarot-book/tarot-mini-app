import 'package:flutter/material.dart';
import 'package:tarot_mini_app/widgets/utils/text_section.dart';
import '../../models/deck.dart';
// Correct the import!

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
        child: TextSection(
          title: deck.name,
          content: deck.description,
          textAlign: textAlign,
          useContainer: false, // or true if you want background
        ),
      ),
    );
  }
}
