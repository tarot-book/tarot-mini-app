import 'package:flutter/material.dart';
import '../../models/deck.dart';
import 'deck_view.dart';

/// A single carousel arrow that can overflow its container
class CarouselArrow extends StatelessWidget {
  final bool isLeft;
  final VoidCallback onPressed;
  final bool visible;
  final double horizontalOffset;

  const CarouselArrow({
    super.key,
    required this.isLeft,
    required this.onPressed,
    this.visible = true,
    this.horizontalOffset = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    if (!visible) return const SizedBox.shrink();

    return Positioned(
      left: isLeft ? -horizontalOffset : null,
      right: isLeft ? null : -horizontalOffset,
      child: IconButton(
        iconSize: 48,
        icon: Icon(isLeft ? Icons.arrow_left : Icons.arrow_right),
        color: Colors.white70,
        onPressed: onPressed,
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(),
      ),
    );
  }
}

/// Carousel of decks with dynamic sizing to ensure arrows align with card edges
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

  void _goToPage(int index) {
    if (index >= 0 && index < decks.length) {
      controller.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
      onPageChanged(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isNarrow = constraints.maxWidth < 800;

        // In narrow mode, shrink the carousel width so cards don't fill full screen
        final double widthFactor = isNarrow ? 0.8 : 1.0;
        // Arrow offset to overlap card edge by 12px
        final double arrowOffset = isNarrow ? 12.0 : 0.0;

        return Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            // FractionallySizedBox to fix carousel width in narrow mode
            FractionallySizedBox(
              widthFactor: widthFactor,
              child: PageView.builder(
                controller: controller,
                itemCount: decks.length,
                onPageChanged: onPageChanged,
                itemBuilder: (context, index) => DeckCard(deck: decks[index]),
              ),
            ),

            // Left navigation arrow
            CarouselArrow(
              isLeft: true,
              onPressed: () => _goToPage(currentPage - 1),
              visible: currentPage > 0,
              horizontalOffset: arrowOffset,
            ),

            // Right navigation arrow
            CarouselArrow(
              isLeft: false,
              onPressed: () => _goToPage(currentPage + 1),
              visible: currentPage < decks.length - 1,
              horizontalOffset: arrowOffset,
            ),
          ],
        );
      },
    );
  }
}
