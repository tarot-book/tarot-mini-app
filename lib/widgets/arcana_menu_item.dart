import 'package:flutter/material.dart';

class ArcanaMenuItem extends StatefulWidget {
  final String title;
  final String imagePath;
  final VoidCallback onTap;

  const ArcanaMenuItem({
    super.key,
    required this.title,
    required this.imagePath,
    required this.onTap,
  });

  @override
  State<ArcanaMenuItem> createState() => _ArcanaMenuItemState();
}

class _ArcanaMenuItemState extends State<ArcanaMenuItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          color: isDark
              ? (_isHovered ? Colors.grey[850] : Colors.grey[900])
              : (_isHovered ? Colors.grey[200] : Colors.white),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isDark ? Colors.white24 : Colors.black12,
          ),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: isDark ? Colors.yellow.withOpacity(0.3) : Colors.black26,
                    blurRadius: 16,
                    offset: const Offset(0, 8),
                  ),
                ]
              : [],
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: widget.onTap,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  widget.imagePath,
                  height: 100,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 12),
                Text(
                  widget.title,
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
