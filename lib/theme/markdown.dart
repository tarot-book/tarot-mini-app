import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:tarot_mini_app/theme/colors.dart';

MarkdownStyleSheet buildMarkdownStyleSheet(BuildContext context) {
  final theme = Theme.of(context);
  final textTheme = theme.textTheme;
  final colorScheme = theme.colorScheme;

  return MarkdownStyleSheet(
    h1: textTheme.headlineLarge, // keep h1 big
    h2: textTheme.headlineSmall, // make h2 smaller
    h3: textTheme.titleLarge,
    p: textTheme.bodyMedium?.copyWith(height: 1.5),
    listBullet: textTheme.bodyMedium?.copyWith(
      color: colorScheme.secondary,
      fontSize: (textTheme.bodyMedium?.fontSize ?? 16) + 4,
      fontWeight: FontWeight.bold,
    ),
    blockSpacing: 16,
    textAlign: WrapAlignment.start,
    horizontalRuleDecoration: BoxDecoration(
      border: Border(
        top: BorderSide(
          color:
              AppColors.textSecondary, // или AppColors.border, если используешь
          width: 0.5, // тонкая линия
        ),
      ),
    ),
  );
}
