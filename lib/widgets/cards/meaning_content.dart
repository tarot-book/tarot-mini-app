import 'package:flutter/material.dart';
import 'package:tarot_mini_app/widgets/utils/markdown_section.dart';

/// A widget that displays tarot card meaning text in a styled container.
/// Can be used for both straight and reversed meanings.
class MeaningContent extends StatelessWidget {
  final String text;

  const MeaningContent({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return MarkdownSection(data: text);
  }
}
