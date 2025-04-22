// lib/routes/app_router.dart
import 'package:flutter/material.dart';
import 'package:tarot_mini_app/screens/card_detail_screen.dart';
import 'package:tarot_mini_app/screens/home_screen.dart';
import 'package:tarot_mini_app/screens/major_arcana_screen.dart';
import 'package:tarot_mini_app/screens/minor_arcana_screen.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/major':
        final args = settings.arguments as Map<String, dynamic>;
        final deckId = args['deckId'] as int;
        return MaterialPageRoute(
          builder: (_) => MajorArcanaScreen(deckId: deckId),
        );

      case '/minor':
        final args = settings.arguments as Map<String, dynamic>;
        final deckId = args['deckId'] as int;
        return MaterialPageRoute(
          builder: (_) => MinorArcanaScreen(deckId: deckId),
        );
      case '/card':
        final args = settings.arguments as Map<String, dynamic>;
        final id = args['cardId'] as int;
        final arcanaType = args['arcanaType'] as String; // 'major' или 'minor'

        return MaterialPageRoute(
          builder: (_) => CardDetailScreen(cardId: id, arcanaType: arcanaType),
        );

      case '/':
      default:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
    }
  }
}
