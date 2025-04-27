import 'package:flutter/material.dart';

/// A widget that displays a tarot card thumbnail
/// and opens a full-screen viewer that grows out of the thumbnail,
/// handling reversed cards correctly.
class CardImage extends StatelessWidget {
  final String imageUrl;
  final bool isReverted;

  const CardImage({
    super.key,
    required this.imageUrl,
    this.isReverted = false,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click, // Show pointer on hover
      child: GestureDetector(
        onTap: () {
          final renderBox = context.findRenderObject() as RenderBox;
          final origin = renderBox.localToGlobal(Offset.zero);
          final thumbSize = renderBox.size;

          showGeneralDialog(
            context: context,
            barrierDismissible: true,
            barrierLabel: 'Dismiss',
            barrierColor: Colors.black54,
            transitionDuration: const Duration(milliseconds: 500),
            pageBuilder: (_, __, ___) => const SizedBox.shrink(),
            transitionBuilder: (ctx, anim, __, ___) {
              final t = Curves.easeInOut.transform(anim.value);
              final startRect = Rect.fromLTWH(
                origin.dx,
                origin.dy,
                thumbSize.width,
                thumbSize.height,
              );
              final screen = MediaQuery.of(ctx).size;
              final endRect = Rect.fromLTWH(0, 0, screen.width, screen.height);
              final currentRect = Rect.lerp(startRect, endRect, t)!;

              return Stack(
                children: [
                  Positioned.fromRect(
                    rect: currentRect,
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () => Navigator.of(ctx).pop(), // Tap enlarged image to close
                      child: Material(
                        color: Colors.transparent,
                        child: InteractiveViewer(
                          panEnabled: true,
                          minScale: 0.5,
                          maxScale: 4.0,
                          child: Transform.rotate(
                            angle: isReverted ? 3.1416 : 0, // Rotate enlarged image
                            child: Image.network(
                              imageUrl,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: AnimatedRotation(
            turns: isReverted ? 0.5 : 0.0, // 0.5 turns = 180 degrees
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut,
            child: Image.network(
              imageUrl,
              fit: BoxFit.contain,
              height: 400,
              loadingBuilder: (ctx, child, progress) {
                if (progress == null) return child;
                return SizedBox(
                  height: 400,
                  child: Center(
                    child: CircularProgressIndicator(
                      value: progress.expectedTotalBytes != null
                          ? progress.cumulativeBytesLoaded /
                              progress.expectedTotalBytes!
                          : null,
                    ),
                  ),
                );
              },
              errorBuilder: (ctx, error, stack) => Container(
                height: 400,
                color: Colors.grey.shade200,
                child: const Icon(
                  Icons.broken_image,
                  size: 48,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
