import 'package:flutter/material.dart';
import 'package:tarot_mini_app/models/card.dart';

import 'package:tarot_mini_app/services/card_service.dart';

class CardDetailScreen extends StatefulWidget {
  final int cardId;
  final String arcanaType; // 'major' or 'minor'

  const CardDetailScreen({super.key, required this.cardId, required this.arcanaType});

  @override
  State<CardDetailScreen> createState() => _CardDetailScreenState();
}

class _CardDetailScreenState extends State<CardDetailScreen> {
  late Future<FullCardData> _cardFuture;

  @override
  void initState() {
    super.initState();
    _cardFuture = widget.arcanaType == 'major'
        ? CardService().fetchMajorCardDetail(widget.cardId)
        : CardService().fetchMinorCardDetail(widget.cardId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder<FullCardData>(
        future: _cardFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Ошибка: ${snapshot.error}'));
          }
          final card = snapshot.data!;
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.network(card.imageUrl),
                const SizedBox(height: 24),
                Text(
                  card.name,
                  style: Theme.of(context).textTheme.headlineLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ...card.meanings.map((m) => Text(
                      '${m.position} — Source #${m.source}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    )),
              ],
            ),
          );
        },
      ),
    );
  }
}