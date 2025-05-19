import 'package:flutter/material.dart';
import '../../theme/colors.dart';

class SourceSelectorButton extends StatelessWidget {
  final String name;
  final VoidCallback onTap;
  const SourceSelectorButton({
    super.key,
    required this.name,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [

        Align(
          alignment: Alignment.centerLeft,
          child: OutlinedButton(
            onPressed: onTap,
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              side: BorderSide(color: AppColors.border),
              foregroundColor: AppColors.textPrimary,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              textStyle: theme.textTheme.labelLarge,
            ),
            child: const Text('Выбрать источник ...'),
          ),
        ),
      ],
    );
  }
}
