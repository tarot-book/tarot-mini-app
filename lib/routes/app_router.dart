// lib/routes/app_router.dart
import 'package:flutter/material.dart';
import 'package:tarot_mini_app/models/arcana_type.dart';
import 'package:tarot_mini_app/screens/card_detail_screen.dart';
import 'package:tarot_mini_app/screens/home_screen.dart';
import 'package:tarot_mini_app/screens/major_arcana_screen.dart';
import 'package:tarot_mini_app/screens/minor_arcana_screen.dart';

class AppRouter {
  static Map<String, dynamic> _extractArgs(RouteSettings settings) {
    final args = settings.arguments;
    if (args is Map<String, dynamic>) return args;
    throw ArgumentError('Expected Map<String, dynamic> in route arguments');
  }

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/major':
        final deck = _extractArgs(settings)['deck'];
        return MaterialPageRoute(
          builder: (_) => MajorArcanaScreen(deck: deck),
        );
      case '/minor':
        final deck = _extractArgs(settings)['deck'];
        return MaterialPageRoute(
          builder: (_) => MinorArcanaScreen(deck: deck),
        );
      case '/card':
        final args = settings.arguments as Map<String, dynamic>;
        ArcanaType arcanaType = _extractArgs(settings)['arcanaType'];
        return MaterialPageRoute(
          builder:
              (_) => CardDetailScreen(
                cardId: args['cardId'],
                arcanaType: arcanaType,
              ),
        );

      case '/':
      default:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
    }
  }
}
