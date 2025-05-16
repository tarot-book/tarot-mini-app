import 'package:flutter/material.dart';
import 'package:tarot_mini_app/models/deck.dart';
import 'package:tarot_mini_app/models/suit.dart';
import 'package:tarot_mini_app/services/logger_service.dart';
import 'package:tarot_mini_app/widgets/suits/suit_card.dart';
import 'package:tarot_mini_app/screens/minor_arcana_screen.dart';

class SuitListView extends StatelessWidget {
  final Deck deck;
  final List<Suit> suits;

  const SuitListView({
    super.key,
    required this.deck,
    required this.suits,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: suits.length,
      separatorBuilder: (_, __) => const SizedBox(height: 16),
      shrinkWrap: true,
      itemBuilder: (ctx, i) {
        final suit = suits[i];
        final assetPath = _assetForSuit(suit.id);

        return SuitCard(
          suit: suit,
          assetPath: assetPath,
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => MinorArcanaScreen(deck: deck, suit: suit),
            ),
          ),
        );
      },
    );
  }

  String _assetForSuit(int id) {
    switch (id) {
      case 1:
        return 'assets/images/suits/wands.svg';
      case 2:
        return 'assets/images/suits/swords.svg';
      case 3:
        return 'assets/images/suits/cups.svg';
      case 4:
        return 'assets/images/suits/pentacles.svg';
      default:
        logger.e('Unknown suit id: $id');
        return '';
    }
  }
}
