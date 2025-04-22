import 'package:flutter/material.dart';
import 'package:tarot_mini_app/models/deck.dart';
import 'deck_carousel.dart';
import 'deck_descriptor.dart';

class WideDeckSelectorView extends StatelessWidget {
  final List<Deck> decks;
  final int currentPage;
  final PageController controller;
  final void Function(int) onPageChanged;

  const WideDeckSelectorView({
    super.key,
    required this.decks,
    required this.currentPage,
    required this.controller,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    final deck = decks[currentPage];
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 220,
          height: 260,
          child: DeckCarousel(
            controller: controller,
            decks: decks,
            currentPage: currentPage,
            onPageChanged: onPageChanged,
          ),
        ),
        const SizedBox(width: 24),
        Expanded(child: DeckDescription(deck: deck)),
      ],
    );
  }
}

class NarrowDeckSelectorView extends StatelessWidget {
  final List<Deck> decks;
  final int currentPage;
  final PageController controller;
  final void Function(int) onPageChanged;

  const NarrowDeckSelectorView({
    super.key,
    required this.decks,
    required this.currentPage,
    required this.controller,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    final deck = decks[currentPage];
    return Column(
      children: [
        SizedBox(
          height: 260,
          child: DeckCarousel(
            controller: controller,
            decks: decks,
            currentPage: currentPage,
            onPageChanged: onPageChanged,
          ),
        ),
        const SizedBox(height: 16),
        DeckDescription(deck: deck),
      ],
    );
  }
}
