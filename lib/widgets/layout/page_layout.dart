import 'package:flutter/material.dart';
import 'package:tarot_mini_app/theme/app_layout.dart';

class PageLayout extends StatelessWidget {
  final Widget child;

  const PageLayout({super.key, required this.child});

// lib/widgets/layout/page_layout.dart
@override
Widget build(BuildContext context) {
  final width = MediaQuery.of(context).size.width;
  // порог, ниже которого считаем экран «узким»
  final isNarrow = width < AppLayout.narrowScreenSize;

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
          // вот здесь делаем адаптивный padding
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isNarrow ? AppLayout.horizontalPadding : 32,
              vertical: isNarrow ? AppLayout.horizontalPadding : 32,
            ),
            child: child,
          ),
        ),
      ),
    ),
  );
}

}
