import 'package:flutter/material.dart';
import 'package:tarot_mini_app/models/meaning.dart';
import 'package:tarot_mini_app/widgets/cards/meaning_content.dart';

class MeaningTabs extends StatelessWidget {
  final CardPosition selectedPosition;
  final ValueChanged<CardPosition> onPositionChanged;
  final String straightMeaning;
  final String revertedMeaning;

  const MeaningTabs({
    super.key,
    required this.selectedPosition,
    required this.onPositionChanged,
    required this.straightMeaning,
    required this.revertedMeaning,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            const double widthFactor = 0.9;
            final totalWidth = constraints.maxWidth * widthFactor;
            final buttonWidth = totalWidth / 2;

            final selectedIndex =
                selectedPosition == CardPosition.straight ? 0 : 1;

            return Center(
              child: ToggleButtons(
                renderBorder: true,
                borderWidth: 1,
                borderRadius: BorderRadius.circular(8),
                isSelected: [
                  selectedPosition == CardPosition.straight,
                  selectedPosition == CardPosition.reverted,
                ],
                onPressed: (index) {
                  onPositionChanged(
                    index == 0 ? CardPosition.straight : CardPosition.reverted,
                  );
                },
                constraints: BoxConstraints.tightFor(
                  width: buttonWidth,
                  height: 40,
                ),
                children: List.generate(2, (index) {
                  final isSelected = index == selectedIndex;
                  final label = index == 0 ? 'Прямая' : 'Перевернутая';

                  return Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color:
                          isSelected
                              ? Theme.of(context).colorScheme.secondary
                              : Colors.transparent,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      label,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color:
                            isSelected
                                ? Theme.of(context).colorScheme.onSecondary
                                : Theme.of(context).colorScheme.onSurface,
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  );
                }),
              ),
            );
          },
        ),

        const SizedBox(height: 16),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          child:
              selectedPosition == CardPosition.straight
                  ? MeaningContent(key: ValueKey(1), text: straightMeaning)
                  : MeaningContent(key: ValueKey(2), text: revertedMeaning),
        ),
      ],
    );
  }
}
