import 'package:flutter/material.dart';
import 'package:tarot_mini_app/constants/app_constants.dart';
import 'package:tarot_mini_app/widgets/utils/markdown_section.dart';

class MeaningContent extends StatelessWidget {
  final String text;
  final String source;

  const MeaningContent({super.key, required this.text, required this.source});

  /// Clean and normalize the raw markdown text:
  /// 1) Unescape any double-escaped sequences like `\\n` → `\n`
  /// 2) Convert literal `\r\n` and `\n` into real newline characters
  /// 3) Normalize excessive blank lines into exactly two LF
  String _prepareMarkdown(String raw) {
    var s = raw;

    // 1) Convert double-escaped `\\n` into single-escaped `\n`
    s = s.replaceAll(RegExp(r'\\n'), r'\n');
    // Also handle double-escaped `\\r\\n`
    s = s.replaceAll(RegExp(r'\\r\\n'), r'\r\n');

    // 2) Replace literal escape sequences with real line breaks
    // Replace Windows CRLF first, then any remaining LF escapes
    s = s.replaceAll(r'\r\n', '\n');
    s = s.replaceAll(r'\n', '\n');

    // 3) Collapse three or more real LF into exactly two (paragraph break)
    s = s.replaceAll(RegExp(r'\n{3,}'), '\n\n');

    // Trim leading spaces or invisible chars
    return s.trimLeft();
  }

  @override
  Widget build(BuildContext context) {
    var md = _prepareMarkdown(text);
    if (text != AppConstants.revertedMeaningMissing && text != AppConstants.straightMeaningMissing) {
      md = '$md\n\n——$source';
    }
    return MarkdownSection(data: md);
  }
}
