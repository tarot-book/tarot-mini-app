import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tarot_mini_app/constants/app_constants.dart';
import 'package:tarot_mini_app/models/meaning.dart';
import 'package:tarot_mini_app/providers/position_state.dart';
import 'package:tarot_mini_app/screens/card_detail_screen.dart';
import 'package:tarot_mini_app/widgets/cards/card_image.dart';
import 'package:tarot_mini_app/widgets/cards/meaning_tabs.dart';
import 'package:tarot_mini_app/widgets/sources/source_selector.dart';

class CardDetailWide extends StatelessWidget {
  final CardDetailData data;
  final SourceSelector sourceSelector;

  const CardDetailWide({
    super.key,
    required this.data,
    required this.sourceSelector,
  });

  @override
  Widget build(BuildContext context) {
    final position = context.watch<CardPositionState>();

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 4,
          child: CardImage(
            imageUrl: data.card.imageUrl,
            isReverted: position.position == CardPosition.reverted,
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          flex: 6,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
             
              
              MeaningTabs(
                selectedPosition: position.position,
                onPositionChanged:
                    (newPosition) => position.setPosition(newPosition),
                straightMeaning:
                    data.meanings.straight?.text ??
                    AppConstants.straightMeaningMissing,
                revertedMeaning:
                    data.meanings.reverted?.text ??
                    AppConstants.revertedMeaningMissing,
              ),
              const SizedBox(height: 16),
               sourceSelector,
            ],
          ),
        ),
      ],
    );
  }
}

class CardDetailNarrow extends StatelessWidget {
  final CardDetailData data;
  final SourceSelector sourceSelector;

  const CardDetailNarrow({
    super.key,
    required this.data,
    required this.sourceSelector,
  });

  @override
  Widget build(BuildContext context) {
    final position = context.watch<CardPositionState>();

    final theme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CardImage(
          imageUrl: data.card.imageUrl,
          isReverted: position.position == CardPosition.reverted,
        ),
        const SizedBox(height: 24),
        Text(
          data.card.name,
          style: theme.headlineLarge,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        MeaningTabs(
          selectedPosition: position.position,
          onPositionChanged: (newPosition) => position.setPosition(newPosition),
          straightMeaning:
              data.meanings.straight?.text ??
              AppConstants.straightMeaningMissing,
          revertedMeaning:
              data.meanings.reverted?.text ??
              AppConstants.revertedMeaningMissing,
        ),
        const SizedBox(height: 16),
        sourceSelector,        
      ],
    );
  }
}
