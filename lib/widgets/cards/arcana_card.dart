import 'package:flutter/material.dart';
import 'package:tarot_mini_app/models/card.dart';
import 'package:tarot_mini_app/theme/colors.dart';

class ArcanaCard extends StatelessWidget {
  final ArcanaCardData card;

  const ArcanaCard({super.key, required this.card});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).cardColor,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          Navigator.pushNamed(
            context,
            '/card',
            arguments: {'cardId': card.id, 'arcanaType': card.arcana},
          );
        },
        hoverColor: Theme.of(context).hoverColor,
        splashColor: Theme.of(context).splashColor,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _ArcanaImage(imageUrl: card.imageUrl),
                const SizedBox(height: 4),
                _ArcanaTitle(title: card.title),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Extracted image widget for readability
class _ArcanaImage extends StatelessWidget {
  final String imageUrl;

  const _ArcanaImage({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AspectRatio(
        aspectRatio: 2 / 3,
        child: Image.network(
          imageUrl,
          fit: BoxFit.contain,
          width: double.infinity,
        ),
      ),
    );
  }
}

/// Extracted title overlay widget
class _ArcanaTitle extends StatelessWidget {
  final String title;

  const _ArcanaTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      color: AppColors.overlayDark,
      child: Text(
        title,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),
        textAlign: TextAlign.center,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
