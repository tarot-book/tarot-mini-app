import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tarot_mini_app/models/deck.dart';
import 'package:tarot_mini_app/providers/app_state.dart';
import 'package:tarot_mini_app/theme/app_layout.dart';
import 'deck_selector_layouts.dart';
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
    final selectedDeck = widget.decks[index];
    Provider.of<AppState>(context, listen: false).selectDeck(selectedDeck.id);    
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    // initialize the provider
    WidgetsBinding.instance.addPostFrameCallback((_) {
    final firstDeck = widget.decks.isNotEmpty ? widget.decks[0] : null;
    if (firstDeck != null) {
      Provider.of<AppState>(context, listen: false).selectDeck(firstDeck.id);
    }
  });  
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final deck = widget.decks[_currentPage];
    final isWide =
        MediaQuery.of(context).size.width > AppLayout.maxParagraphWidth;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppLayout.horizontalPadding,
          ),
          child:
              isWide
                  ? WideDeckSelectorView(
                    decks: widget.decks,
                    currentPage: _currentPage,
                    controller: _pageController,
                    onPageChanged: _goToPage,
                  )
                  : NarrowDeckSelectorView(
                    decks: widget.decks,
                    currentPage: _currentPage,
                    controller: _pageController,
                    onPageChanged: _goToPage,
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
