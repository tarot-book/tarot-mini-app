import 'package:flutter/material.dart';
import '../../models/deck.dart';
import 'deck_view.dart';

class CarouselArrow extends StatelessWidget {
  final bool isLeft;
  final VoidCallback onPressed;
  final bool visible;

  const CarouselArrow({
    super.key,
    required this.isLeft,
    required this.onPressed,
    this.visible = true,
  });

  @override
  Widget build(BuildContext context) {
    if (!visible) return const SizedBox.shrink();

    return Positioned(
      left: isLeft ? 0 : null,
      right: isLeft ? null : 0,
      child: IconButton(
        icon: Icon(
          isLeft ? Icons.arrow_left : Icons.arrow_right,
          size: 32,
        ),
        color: Colors.white70,
        onPressed: onPressed,
        hoverColor: Colors.white24
      ),
    );
  }
}


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
        controller.animateToPage(
          index,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
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
        CarouselArrow(
          isLeft: true,
          onPressed: () => goToPage(currentPage - 1),
          visible: currentPage > 0,
        ),
        CarouselArrow(
          isLeft: false,
          onPressed: () => goToPage(currentPage + 1),
          visible: currentPage < decks.length - 1,
        ),
      ],
    );
  }
}