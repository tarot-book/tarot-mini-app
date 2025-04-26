import 'package:flutter/material.dart';

/// A widget that displays a tarot card image preview and opens a full-screen viewer on tap.
class CardImage extends StatelessWidget {
  final String imageUrl;

  const CardImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (_) => Dialog(
            insetPadding: const EdgeInsets.all(16),
            child: InteractiveViewer(
              panEnabled: true,
              minScale: 0.5,
              maxScale: 4.0,
              child: AspectRatio(
                aspectRatio: 2 / 3,
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, progress) {
            if (progress == null) return child;
            return SizedBox(
              height: 150,
              child: Center(
                child: CircularProgressIndicator(
                  value: progress.expectedTotalBytes != null
                      ? progress.cumulativeBytesLoaded / progress.expectedTotalBytes!
                      : null,
                ),
              ),
            );
          },
          errorBuilder: (context, error, stack) => Container(
            height: 150,
            color: Colors.grey.shade200,
            child: const Icon(
              Icons.broken_image,
              size: 48,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
