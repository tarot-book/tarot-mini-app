import 'package:flutter/material.dart';
import 'package:tarot_mini_app/models/card.dart';
import 'package:tarot_mini_app/models/deck.dart';
import 'package:tarot_mini_app/models/suit.dart';
import 'package:tarot_mini_app/services/card_service.dart';
import 'package:tarot_mini_app/widgets/cards/arcana_grid.dart';

class MinorArcanaScreen extends StatefulWidget {
  final Deck deck;
  final Suit suit;


  const MinorArcanaScreen({super.key, required this.deck, required this.suit});
  @override
  State<MinorArcanaScreen> createState() => _MinorArcanaScreenState();
}

class _MinorArcanaScreenState extends State<MinorArcanaScreen> {
  late Future<List<ArcanaCardData>> _cardsFuture;

  @override
  void initState() {
    super.initState();
    _cardsFuture = CardService().fetchMinorCards(widget.deck.id, widget.suit.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Младшие арканы - ${widget.suit.name}')),
      body: FutureBuilder<List<ArcanaCardData>>(
        future: _cardsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Ошибка загрузки карт'));
          }

          final cards = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.deck.name,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                const SizedBox(height: 16),
                Expanded(child: ArcanaGrid(cards: cards)),
              ],
            ),
          );
        },
      ),
    );
  }
}
