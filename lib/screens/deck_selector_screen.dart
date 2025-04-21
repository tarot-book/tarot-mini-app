import 'package:flutter/material.dart';
import '../models/deck.dart';
import '../widgets/decks/deck_selector.dart';
import '../services/deck_service.dart';

class DeckSelectorScreen extends StatefulWidget {
  const DeckSelectorScreen({super.key});

  @override
  State<DeckSelectorScreen> createState() => _DeckSelectorScreenState();
}

class _DeckSelectorScreenState extends State<DeckSelectorScreen> {
  late Future<List<Deck>> _futureDecks;

  @override
  void initState() {
    super.initState();
    _futureDecks = DeckService().fetchDecks();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Deck>>(
      future: _futureDecks,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No decks found.'));
        } else {
          return DeckSelector(decks: snapshot.data!);
        }
      },
    );
  }
}
