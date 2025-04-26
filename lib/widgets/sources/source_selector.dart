import 'package:flutter/material.dart';
import 'package:tarot_mini_app/widgets/sources/source_picker.dart';
import 'package:tarot_mini_app/widgets/utils/link_button.dart';


/// A widget that shows the current source as a link and opens a picker.
class SourceSelector extends StatelessWidget {
  final List<String> sources;
  final int selectedIndex;
  final ValueChanged<int> onSourceChanged;

  const SourceSelector({
    super.key,
    required this.sources,
    required this.selectedIndex,
    required this.onSourceChanged,
  });

  @override
  Widget build(BuildContext context) {
    return LinkButton(
      text: sources[selectedIndex],
      onTap: () => _showSourcePicker(context),
    );
  }

  void _showSourcePicker(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      // назначаем такое же скругление, как у списковых элементов
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      // обязательно, чтобы дочерние виджеты обрезались по этой форме
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
