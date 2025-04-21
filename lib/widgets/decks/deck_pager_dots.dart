import 'package:flutter/material.dart';

class DeckPagerDots extends StatelessWidget {
  final int count;
  final int currentIndex;
  final ValueChanged<int> onTap;

  const DeckPagerDots({
    super.key,
    required this.count,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (index) {
        final isActive = index == currentIndex;
        return GestureDetector(
          onTap: () => onTap(index),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: const EdgeInsets.symmetric(horizontal: 4),
            width: isActive ? 12 : 8,
            height: 8,
            decoration: BoxDecoration(
              color: isActive ? Colors.amber : Colors.grey,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        );
      }),
    );
  }
}
