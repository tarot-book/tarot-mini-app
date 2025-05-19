import 'package:flutter/material.dart';
import 'package:tarot_mini_app/models/source.dart';
import 'package:tarot_mini_app/widgets/sources/source_picker.dart';
import 'package:tarot_mini_app/widgets/sources/source_selector_button.dart';


/// A widget that shows the current source as a link and opens a picker.
class SourceSelector extends StatelessWidget {
  final List<Source> sources;
  final int selectedIndex;
  final ValueChanged<int> onSourceChanged;

  const SourceSelector({
    super.key,
    required this.sources,
    required this.selectedIndex,
    required this.onSourceChanged,
  });

  String get selectedSource => sources[selectedIndex].name;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: SourceSelectorButton(
        name: sources[selectedIndex].name,
        onTap: () => _showSourcePicker(context),
      ),
    );
  }

  void _showSourcePicker(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      clipBehavior: Clip.antiAlias,
      builder:
          (_) => SourcePickerSheet(
            sources: sources,
            selectedIndex: selectedIndex,
            onSelected: onSourceChanged,
          ),
    );
  }
}
