import 'package:flutter/material.dart';
import 'package:tarot_mini_app/models/card.dart';
import 'package:tarot_mini_app/models/deck.dart';
import 'package:tarot_mini_app/services/card_service.dart';
import 'package:tarot_mini_app/widgets/cards/arcana_grid.dart';
import 'package:tarot_mini_app/widgets/layout/page_layout.dart';

class MajorArcanaScreen extends StatefulWidget {
  final Deck deck;

  const MajorArcanaScreen({super.key, required this.deck});

  @override
  State<MajorArcanaScreen> createState() => _MajorArcanaScreenState();
}

class _MajorArcanaScreenState extends State<MajorArcanaScreen> {
  late Future<List<ArcanaCardData>> _cardsFuture;

  @override
  void initState() {
    super.initState();
    _cardsFuture = CardService().fetchMajorCards(widget.deck.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Старшие арканы')),
      body: PageLayout(
        child: FutureBuilder<List<ArcanaCardData>>(
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
      ),
    );
  }
}
