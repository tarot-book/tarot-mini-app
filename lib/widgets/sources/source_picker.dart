import 'package:flutter/material.dart';

/// A bottom sheet widget listing sources with a checkmark for the selected one.
/// Use inside showModalBottomSheet builder.
class SourcePickerSheet extends StatelessWidget {
  final List<String> sources;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  const SourcePickerSheet({
    Key? key,
    required this.sources,
    required this.selectedIndex,
    required this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: sources.length,
        separatorBuilder: (_, __) => Divider(color: theme.dividerColor, height: 1),
        itemBuilder: (context, index) {
          final isSelected = index == selectedIndex;
          return ListTile(
            title: Text(
              sources[index],
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface,
              ),
            ),
            trailing: isSelected
                ? Icon(Icons.check, color: theme.colorScheme.secondary)
                : null,
            selected: isSelected,
            onTap: () {
              Navigator.of(context).pop();
              onSelected(index);
            },
          );
        },
      ),
    );
  }
}
