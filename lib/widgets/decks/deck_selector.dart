import 'package:flutter/material.dart';
import 'package:tarot_mini_app/models/deck.dart';
import 'package:tarot_mini_app/widgets/decks/deck_descriptor.dart';
import 'deck_carousel.dart';
import 'deck_pager_dots.dart';

class DeckSelector extends StatefulWidget {
  final List<Deck> decks;

  const DeckSelector({super.key, required this.decks});

  @override
  State<DeckSelector> createState() => _DeckSelectorState();
}

class _DeckSelectorState extends State<DeckSelector> {
  int _currentPage = 0;
  late final PageController _pageController;

  void _goToPage(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );    
    setState(() => _currentPage = index);
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }  

  @override
  Widget build(BuildContext context) {
    final deck = widget.decks[_currentPage];
    final isWide = MediaQuery.of(context).size.width > 600;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: isWide
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 220,
                      height: 260,
                      child: DeckCarousel(
                        controller: _pageController,
                        decks: widget.decks,
                        currentPage: _currentPage,
                        onPageChanged: _goToPage,
                      ),
                    ),
                    const SizedBox(width: 24),
                    Expanded(child: DeckDescription(deck: deck)),
                  ],
                )
              : Column(
                  children: [
                    SizedBox(
                      height: 260,
                      child: DeckCarousel(
                        controller: _pageController,
                        decks: widget.decks,
                        currentPage: _currentPage,
                        onPageChanged: _goToPage,
                      ),
                    ),
                    const SizedBox(height: 16),
                    DeckDescription(deck: deck),
                  ],
                ),
        ),
        const SizedBox(height: 16),
        DeckPagerDots(
          count: widget.decks.length,
          currentIndex: _currentPage,
          onTap: _goToPage,
        ),
      ],
    );
  }
}
