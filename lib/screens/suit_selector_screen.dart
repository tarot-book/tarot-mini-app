// file: lib/screens/suit_selector_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tarot_mini_app/models/suit.dart';
import 'package:tarot_mini_app/providers/app_state.dart';
import 'package:tarot_mini_app/services/logger_service.dart';
import 'package:tarot_mini_app/services/suit_service.dart';
import 'package:tarot_mini_app/widgets/layout/page_layout.dart';
import 'package:tarot_mini_app/widgets/suits/suit_card.dart';
import 'minor_arcana_screen.dart';

class SuitSelectorScreen extends StatefulWidget {
  const SuitSelectorScreen({super.key});

  @override
  SuitSelectorScreenState createState() => SuitSelectorScreenState();
}

class SuitSelectorScreenState extends State<SuitSelectorScreen> {
  late Future<List<Suit>> _futureSuits;

  @override
  void initState() {
    super.initState();
    _futureSuits = SuitService().fetchSuits();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Выберите масть')),
      body: PageLayout(
        child: FutureBuilder<List<Suit>>(
          future: _futureSuits,
          builder: (ctx, snap) {
            if (snap.connectionState != ConnectionState.done) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snap.hasError) {
              return Center(child: Text('Ошибка: ${snap.error}'));
            }
            final suits = snap.data!;

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: suits.length,
                separatorBuilder: (_, __) => const SizedBox(height: 16),
                shrinkWrap: true,
                itemBuilder: (ctx, i) {
                  final suit = suits[i];
                  final assetPath = _assetForSuit(suit.id);
                  final deck = Provider.of<AppState>(context).selectedDeck;
                  return SuitCard(
                    suit: suit,
                    assetPath: assetPath,
                    onTap:
                        () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder:
                                (_) =>
                                    MinorArcanaScreen(deck: deck!, suit: suit),
                          ),
                        ),
                  );
                },
              ),
            );
          },
        ),
      ),
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
         return 'assets/images/suits/wands.svg'; // TODO: use some placeholder
    }
  }
}
