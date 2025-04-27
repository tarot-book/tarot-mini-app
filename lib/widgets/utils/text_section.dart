import 'package:flutter/material.dart';

/// A reusable widget for displaying a titled section of text content.
/// Useful for deck descriptions, card meanings, about pages, etc.
class TextSection extends StatelessWidget {
  final String? title;
  final String content;
  final TextAlign textAlign;
  final EdgeInsetsGeometry padding;
  final double maxWidth;
  final bool useContainer;

  const TextSection({
    super.key,
    this.title,
    required this.content,
    this.textAlign = TextAlign.start,
    this.padding = const EdgeInsets.all(12),
    this.maxWidth = 600,
    this.useContainer = false,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    Widget inner = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null) ...[
          Text(
            title!,
            style: textTheme.headlineLarge,
          ),
          const SizedBox(height: 8),
        ],
        Text(
          content,
          textAlign: textAlign,
          style: textTheme.bodyMedium,
        ),
      ],
    );

    if (useContainer) {
      inner = Container(
        padding: padding,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(8),
        ),
        child: inner,
      );
    }

    return Align(
      alignment: Alignment.topLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: inner,
      ),
    );
  }
}
