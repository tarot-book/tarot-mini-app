import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:tarot_mini_app/theme/markdown.dart';
import 'package:url_launcher/url_launcher.dart';

/// A reusable widget for displaying formatted Markdown content
/// with automatic link handling and fade-in animation.
class MarkdownSection extends StatefulWidget {
  final String data;
  final double maxWidth;
  final EdgeInsetsGeometry padding;
  final Duration animationDuration;

  const MarkdownSection({
    super.key,
    required this.data,
    this.maxWidth = 600,
    this.padding = const EdgeInsets.all(12),
    this.animationDuration = const Duration(milliseconds: 500),
  });

  @override
  State<MarkdownSection> createState() => _MarkdownSectionState();
}

class _MarkdownSectionState extends State<MarkdownSection> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  Future<void> _onTapLink(String? text, String? href, String? title) async {
    if (href == null) return;

    final uri = Uri.tryParse(href);
    if (uri != null && await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      debugPrint('Could not launch $href');
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
    _controller.forward(); // Start animation immediately
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: Align(
        alignment: Alignment.topLeft,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: widget.maxWidth),
          child: Padding(
            padding: widget.padding,
            child: MarkdownBody(
              data: widget.data,
              styleSheet: buildMarkdownStyleSheet(context),
              onTapLink: _onTapLink,
            ),
          ),
        ),
      ),
    );
  }
}
