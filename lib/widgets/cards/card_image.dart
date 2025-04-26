// file: lib/widgets/cards/card_image.dart

import 'package:flutter/material.dart';

/// A widget that displays a tarot card thumbnail and
/// opens a full-screen viewer that grows out of the thumbnail.
class CardImage extends StatelessWidget {
  final String imageUrl;

  const CardImage({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,  // show pointer on hover
      child: GestureDetector(
        onTap: () {
          // measure thumbnail’s position & size
          final renderBox = context.findRenderObject() as RenderBox;
          final origin = renderBox.localToGlobal(Offset.zero);
          final thumbSize = renderBox.size;

          showGeneralDialog(
            context: context,
            barrierDismissible: true,       // tap outside to dismiss
            barrierLabel: 'Dismiss',
            barrierColor: Colors.black54,   // dimmed background
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
                  // growing/shrinking image
                  Positioned.fromRect(
                    rect: currentRect,
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () => Navigator.of(ctx).pop(),  // tap enlarged image to close
                      child: Material(
                        color: Colors.transparent,
                        child: InteractiveViewer(
                          panEnabled: true,
                          minScale: 0.5,
                          maxScale: 4.0,
                          child: Image.network(
                            imageUrl,
                            fit: BoxFit.contain,
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
        // thumbnail
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
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
    );
  }
}
