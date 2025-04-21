import 'package:flutter/material.dart';
import '../../models/deck.dart';
import 'deck_view.dart';

class DeckCarousel extends StatelessWidget {
  final PageController controller;
  final List<Deck> decks;
  final int currentPage;
  final ValueChanged<int> onPageChanged;

  const DeckCarousel({
    super.key,
    required this.controller,
    required this.decks,
    required this.currentPage,
    required this.onPageChanged,
  });



  @override
  Widget build(BuildContext context) {

    void goToPage(int index) {
      if (index >= 0 && index < decks.length) {
        controller.animateToPage(index, duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
        onPageChanged(index);
      }
    }

    return Stack(
      alignment: Alignment.center,
      children: [
        GestureDetector(
          onHorizontalDragEnd: (details) {
            if (details.primaryVelocity == null) return;
            if (details.primaryVelocity! < 0 && currentPage < decks.length - 1) {
              goToPage(currentPage + 1);
            } else if (details.primaryVelocity! > 0 && currentPage > 0) {
              goToPage(currentPage - 1);
            }
          },
          child: PageView.builder(
            controller: controller,
            itemCount: decks.length,
            onPageChanged: onPageChanged,
            itemBuilder: (context, index) => DeckCard(deck: decks[index]),
          ),
        ),
        if (currentPage > 0)
          Positioned(
            left: 0,
            child: IconButton(
              icon: const Icon(Icons.arrow_left, size: 32),
              color: Colors.white70,
              onPressed: () => goToPage(currentPage - 1),
            ),
          ),
        if (currentPage < decks.length - 1)
          Positioned(
            right: 0,
            child: IconButton(
              icon: const Icon(Icons.arrow_right, size: 32),
              color: Colors.white70,
              onPressed: () => goToPage(currentPage + 1),
            ),
          ),
      ],
    );
  }
}
