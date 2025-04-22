import 'package:flutter/material.dart';
import 'package:tarot_mini_app/models/arcana_card_data.dart';

class ArcanaCard extends StatelessWidget {
  final ArcanaCardData card;

  const ArcanaCard({super.key, required this.card});

  @override
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Stack(
        children: [
          AspectRatio(
            aspectRatio: 2 / 3,
            child: Image.network(
              card.imageUrl,
              fit: BoxFit.contain,
              width: double.infinity,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              color: Colors.black.withOpacity(0.7),
              child: Text(
                card.title,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: Colors.white),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
