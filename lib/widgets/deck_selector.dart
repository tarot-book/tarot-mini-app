import 'package:flutter/material.dart';
import '../models/deck.dart';

class DeckSelector extends StatefulWidget {
  final List<Deck> decks;

  const DeckSelector({super.key, required this.decks});

  @override
  State<DeckSelector> createState() => _DeckSelectorState();
}

class _DeckSelectorState extends State<DeckSelector> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 1.0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goToPage(int index) {
    if (index >= 0 && index < widget.decks.length) {
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
      setState(() => _currentPage = index);
    }
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
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          GestureDetector(
                            onHorizontalDragEnd: (details) {
                              if (details.primaryVelocity == null) return;

                              if (details.primaryVelocity! < 0 && _currentPage < widget.decks.length - 1) {
                                _goToPage(_currentPage + 1);
                              } else if (details.primaryVelocity! > 0 && _currentPage > 0) {
                                _goToPage(_currentPage - 1);
                              }
                            },
                            child: PageView.builder(
                              controller: _pageController,
                              itemCount: widget.decks.length,
                              onPageChanged: (index) {
                                setState(() => _currentPage = index);
                              },
                              itemBuilder: (context, index) => _DeckCard(deck: widget.decks[index]),
                            ),
                          ),
                          Positioned(
                            left: 0,
                            child: IconButton(
                              icon: const Icon(Icons.arrow_left, size: 32),
                              color: Colors.white70,
                              onPressed: _currentPage > 0 ? () => _goToPage(_currentPage - 1) : null,
                            ),
                          ),
                          Positioned(
                            right: 0,
                            child: IconButton(
                              icon: const Icon(Icons.arrow_right, size: 32),
                              color: Colors.white70,
                              onPressed: _currentPage < widget.decks.length - 1 ? () => _goToPage(_currentPage + 1) : null,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 24),
                    Expanded(
                      child: DeckDescription(deck: deck),
                    ),
                  ],
                )
              : Column(
                  children: [
                    SizedBox(
                      height: 260,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          GestureDetector(
                            onHorizontalDragEnd: (details) {
                              if (details.primaryVelocity == null) return;

                              if (details.primaryVelocity! < 0 && _currentPage < widget.decks.length - 1) {
                                _goToPage(_currentPage + 1);
                              } else if (details.primaryVelocity! > 0 && _currentPage > 0) {
                                _goToPage(_currentPage - 1);
                              }
                            },
                            child: PageView.builder(
                              controller: _pageController,
                              itemCount: widget.decks.length,
                              onPageChanged: (index) {
                                setState(() => _currentPage = index);
                              },
                              itemBuilder: (context, index) => _DeckCard(deck: widget.decks[index]),
                            ),
                          ),
                          Positioned(
                            left: 0,
                            child: IconButton(
                              icon: const Icon(Icons.arrow_left, size: 32),
                              color: Colors.white70,
                              onPressed: _currentPage > 0 ? () => _goToPage(_currentPage - 1) : null,
                            ),
                          ),
                          Positioned(
                            right: 0,
                            child: IconButton(
                              icon: const Icon(Icons.arrow_right, size: 32),
                              color: Colors.white70,
                              onPressed: _currentPage < widget.decks.length - 1 ? () => _goToPage(_currentPage + 1) : null,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    DeckDescription(deck: deck),
                  ],
                ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(widget.decks.length, (index) {
            final isActive = index == _currentPage;
            return GestureDetector(
              onTap: () => _goToPage(index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: isActive ? 12 : 8,
                height: 8,
                decoration: BoxDecoration(
                  color: isActive ? Colors.amber : Colors.grey,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}

class _DeckCard extends StatelessWidget {
  final Deck deck;

  const _DeckCard({required this.deck});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 150,
        height: 250,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 12,
              offset: const Offset(0, 6),
            )
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.network(
            deck.image,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => const Icon(Icons.broken_image),
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }
}

class DeckDescription extends StatelessWidget {
  final Deck deck;

  const DeckDescription({super.key, required this.deck});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          deck.name,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        const SizedBox(height: 8),
        Text(
          deck.description,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
