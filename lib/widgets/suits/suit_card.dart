
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tarot_mini_app/models/suit.dart';
import 'package:tarot_mini_app/theme/colors.dart';

/// A single tile/card for a tarot suit with icon + label + tap handler.
class SuitCard extends StatelessWidget {
  final Suit suit;
  final String assetPath;
  final VoidCallback onTap;
  final double iconHeight;

  const SuitCard({
    super.key,
    required this.suit,
    required this.assetPath,
    required this.onTap,
    this.iconHeight = 64,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return SizedBox(
      width: 160,
      child: Material(
        color: isDark ? Colors.grey[900] : Colors.white,
        borderRadius: BorderRadius.circular(12),
        elevation: 4,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          splashColor: AppColors.amberSplash,
          highlightColor: AppColors.amberHighlight,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SuitIcon(assetPath: assetPath, size: iconHeight),
                const SizedBox(height: 12),
                Text(
                  suit.name,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: isDark ? Colors.white : null,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


/// A widget that displays an SVG from assets with a placeholder and
class SuitIcon extends StatelessWidget {
  final String assetPath;
  final double size;

  const SuitIcon({super.key, required this.assetPath, this.size = 64});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      assetPath,
      width: size,
      height: size,
      fit: BoxFit.contain,
      placeholderBuilder:
          (_) => SizedBox(
            width: size,
            height: size,
            child: const Center(
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          ),
    );
  }
}
