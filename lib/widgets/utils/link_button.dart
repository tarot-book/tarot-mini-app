import 'package:flutter/material.dart';

/// A minimal hyperlink-style button that opens a callback on tap.
/// Displays a pointer cursor on hover.
class LinkButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final TextStyle? style;

  const LinkButton({
    super.key,
    required this.text,
    required this.onTap,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    final defaultStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: Theme.of(context).colorScheme.secondary,
          decoration: TextDecoration.underline,
          decorationStyle: TextDecorationStyle.dashed,
          decorationThickness: 1.5,
        );

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 4.0), // space between text and underline
          child: Text(
            text,
            style: style ?? defaultStyle,
          ),
        ),
      ),
    );
  }
}
