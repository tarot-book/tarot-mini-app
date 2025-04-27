import 'package:flutter/material.dart';
import 'package:tarot_mini_app/models/source.dart';

/// A bottom sheet widget listing sources with a checkmark for the selected one.
/// Use inside showModalBottomSheet builder.
class SourcePickerSheet extends StatelessWidget {
  final List<Source> sources;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  const SourcePickerSheet({
    super.key,
    required this.sources,
    required this.selectedIndex,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          border: Border.all(color: theme.dividerColor),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // drag handle
            Center(
              child: Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(top: 8, bottom: 8),
                decoration: BoxDecoration(
                  color: theme.dividerColor,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                  border: Border.all(color: theme.dividerColor),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Text(
                'Выберите источник',
                style: theme.textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
            ),
            Divider(color: theme.dividerColor, height: 1),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: sources.length,
              separatorBuilder:
                  (_, __) => Divider(color: theme.dividerColor, height: 1),
              itemBuilder: (context, index) {
                final isSelected = index == selectedIndex;
                return ListTile(
                  title: Text(
                    sources[index].name,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  trailing:
                      isSelected
                          ? Icon(
                            Icons.check,
                            color: theme.colorScheme.secondary,
                          )
                          : null,
                  selected: isSelected,
                  onTap: () {
                    Navigator.of(context).pop();
                    onSelected(index);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
