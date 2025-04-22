import 'package:flutter/material.dart';
import 'package:tarot_mini_app/models/card.dart';
import 'package:tarot_mini_app/theme/app_layout.dart';
import 'package:tarot_mini_app/widgets/cards/arcana_card.dart';

class ArcanaGrid extends StatelessWidget {
  final List<ArcanaCardData> cards;

  const ArcanaGrid({super.key, required this.cards});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    const maxCardsInRow = 5;

    final cardWidth = AppLayout.cardThumbnailWidth;
    final spacing = AppLayout.cardGridSpacing;
    final cardsInRow = (screenWidth / (cardWidth + spacing)).floor().clamp(1, maxCardsInRow);

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: cardsInRow,
        mainAxisSpacing: spacing,
        crossAxisSpacing: spacing,
        childAspectRatio: AppLayout.cardAspectRatio,
      ),
      itemCount: cards.length,
      itemBuilder: (context, index) {
        return ArcanaCard(card: cards[index]);
      },
    );
  }
}
