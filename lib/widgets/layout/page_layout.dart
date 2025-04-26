import 'package:flutter/material.dart';
import 'package:tarot_mini_app/theme/app_layout.dart';

class PageLayout extends StatelessWidget {
  final Widget child;

  const PageLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: const EdgeInsets.only(top: 32),
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: AppLayout.maxContentWidth,
          ),
          child: Material(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(18),
            child: Padding(padding: const EdgeInsets.all(32), child: child),
          ),
        ),
      ),
    );
  }
}
