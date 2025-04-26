import 'package:flutter/material.dart';
import 'package:tarot_mini_app/models/meaning.dart';
import 'meaning_content.dart';

/// Generic segmented control widget wrapping ToggleButtons.
/// Ensures equal-width segments that fill available space.
class SegmentedControl<T extends Object> extends StatelessWidget {
  final Map<T, Widget> segments;
  final T selectedValue;
  final ValueChanged<T> onValueChanged;

  const SegmentedControl({
    super.key,
    required this.segments,
    required this.selectedValue,
    required this.onValueChanged,
  });

  @override
  Widget build(BuildContext context) {

    return LayoutBuilder(
      builder: (context, constraints) {
        final count = segments.length;
        final totalWidth = constraints.maxWidth;
        const double bw = 1.0; // ToggleButtons default border width
        final double totalBorder = bw * (count + 1);
        const double horizontalPaddingPerSegment = 24.0; // left+right from _SegmentItem
        final double buttonWidth = (totalWidth - totalBorder - horizontalPaddingPerSegment * count) / count; (totalWidth - totalBorder) / count;

        return Material(
          color: Colors.transparent,
          child: ToggleButtons(
            constraints: BoxConstraints(
              minWidth: buttonWidth,
              maxWidth: buttonWidth,
              minHeight: 36,
            ),
            isSelected: segments.keys.map((k) => k == selectedValue).toList(),
            onPressed: (index) {
              final key = segments.keys.elementAt(index);
              onValueChanged(key);
            },
            children: segments.values.map((widget) {
              return SizedBox(
                width: buttonWidth,
                child: Center(child: widget),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}

/// A widget representing a single segment in the MeaningTabs.
/// Handles label text and selected styling.
class _SegmentItem<T> extends StatelessWidget {
  final String label;
  final bool isSelected;

  const _SegmentItem({
    super.key,
    required this.label,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Text(
        label,
      ),
    );
  }
}

/// A widget that displays two tabs (Straight and Reverted) for tarot card meanings.
/// Uses a segmented control style and animates content changes.
class MeaningTabs extends StatefulWidget {
  final String straightMeaning;
  final String reversedMeaning;

  const MeaningTabs({
    super.key,
    required this.straightMeaning,
    required this.reversedMeaning,
  });

  @override
  State<MeaningTabs> createState() => _MeaningTabsState();
}

class _MeaningTabsState extends State<MeaningTabs> {
  CardPosition _selectedPosition = CardPosition.straight;

  @override
  Widget build(BuildContext context) {
    final segments = <CardPosition, Widget>{
      CardPosition.straight: _SegmentItem<CardPosition>(
        key: const ValueKey(CardPosition.straight),
        label: 'Прямая',
        isSelected: _selectedPosition == CardPosition.straight,
      ),
      CardPosition.reverted: _SegmentItem<CardPosition>(
        key: const ValueKey(CardPosition.reverted),
        label: 'Перевернутая',
        isSelected: _selectedPosition == CardPosition.reverted,
      ),
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SegmentedControl<CardPosition>(
          segments: segments,
          selectedValue: _selectedPosition,
          onValueChanged: (position) => setState(() {
            _selectedPosition = position;
          }),
        ),
        const SizedBox(height: 16),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          switchInCurve: Curves.easeIn,
          switchOutCurve: Curves.easeOut,
          child: _selectedPosition == CardPosition.straight
              ? MeaningContent(
                  key: const ValueKey(CardPosition.straight),
                  text: widget.straightMeaning,
                )
              : MeaningContent(
                  key: const ValueKey(CardPosition.reverted),
                  text: widget.reversedMeaning,
                ),
        ),
      ],
    );
  }
}
