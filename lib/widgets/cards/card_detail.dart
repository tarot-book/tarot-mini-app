import 'package:flutter/material.dart';
import 'package:tarot_mini_app/widgets/cards/card_image.dart';
import 'package:tarot_mini_app/widgets/sources/source_selector.dart';
import 'package:tarot_mini_app/widgets/cards/meaning_tabs.dart';

class CardDetailWide extends StatelessWidget {
  final String imageUrl;
  final List<String> sources;
  final int selectedIndex;
  final ValueChanged<int> onSourceChanged;
  final String straightMeaning;
  final String reversedMeaning;

  const CardDetailWide({
    super.key,
    required this.imageUrl,
    required this.sources,
    required this.selectedIndex,
    required this.onSourceChanged,
    required this.straightMeaning,
    required this.reversedMeaning,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 4, child: CardImage(imageUrl: imageUrl)),
        const SizedBox(width: 24),
        Expanded(
          flex: 6,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SourceSelector(
                sources: sources,
                selectedIndex: selectedIndex,
                onSourceChanged: onSourceChanged,
              ),
              const SizedBox(height: 16),
              MeaningTabs(
                straightMeaning: straightMeaning,
                reversedMeaning: reversedMeaning,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CardDetailNarrow extends StatelessWidget {
  final String imageUrl;
  final String cardName;
  final List<String> sources;
  final int selectedIndex;
  final ValueChanged<int> onSourceChanged;
  final String straightMeaning;
  final String reversedMeaning;

  const CardDetailNarrow({
    super.key,
    required this.imageUrl,
    required this.cardName,
    required this.sources,
    required this.selectedIndex,
    required this.onSourceChanged,
    required this.straightMeaning,
    required this.reversedMeaning,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CardImage(imageUrl: imageUrl),
        const SizedBox(height: 24),
        Text(cardName, style: theme.headlineLarge, textAlign: TextAlign.center),
        const SizedBox(height: 16),
        SourceSelector(
          sources: sources,
          selectedIndex: selectedIndex,
          onSourceChanged: onSourceChanged,
        ),
        const SizedBox(height: 16),
        MeaningTabs(
          straightMeaning: straightMeaning,
          reversedMeaning: reversedMeaning,
        ),
      ],
    );
  }
}
