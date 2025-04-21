import 'package:flutter/material.dart';
import '../models/deck.dart';

class DeckSelector extends StatefulWidget {
  final List<Deck> decks;

  const DeckSelector({super.key, required this.decks});

  @override
  State<DeckSelector> createState() => _DeckSelectorState();
}

class _DeckSelectorState extends State<DeckSelector> {
  late Deck selectedDeck;

  @override
  void initState() {
    super.initState();
    selectedDeck = widget.decks.first;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        const SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SizedBox(
            width: screenWidth,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: widget.decks.map((deck) {
                final isSelected = deck.id == selectedDeck.id;
                return DeckCard(
                  deck: deck,
                  isSelected: isSelected,
                  onTap: () => setState(() => selectedDeck = deck),
                );
              }).toList(),
            ),
          ),
        ),
        const SizedBox(height: 24),
        DeckDescription(deck: selectedDeck),
      ],
    );
  }
}

class DeckCard extends StatefulWidget {
  final Deck deck;
  final bool isSelected;
  final VoidCallback onTap;

  const DeckCard({
    required this.deck,
    required this.isSelected,
    required this.onTap,
    super.key,
  });

  @override
  State<DeckCard> createState() => _DeckCardState();
}

class _DeckCardState extends State<DeckCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isSelected = widget.isSelected;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: GestureDetector(
          onTap: widget.onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOut,
            width: 150,
            height: 250,
            decoration: BoxDecoration(
              color: isDark ? Colors.grey[900] : Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected ? Colors.amber : Colors.white24,
                width: 2,
              ),
              boxShadow: _isHovered || isSelected
                  ? [
                      BoxShadow(
                        color: isSelected
                            ? Colors.amber.withOpacity(0.4)
                            : Colors.yellow.withOpacity(0.2),
                        blurRadius: 16,
                        offset: const Offset(0, 6),
                      ),
                    ]
                  : [],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                widget.deck.image,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
                errorBuilder: (_, __, ___) => const Icon(Icons.broken_image),
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ),
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
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
      ),
    );
  }
}
