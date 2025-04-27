// lib/routes/app_router.dart
import 'package:flutter/material.dart';
import 'package:tarot_mini_app/models/arcana_type.dart';
import 'package:tarot_mini_app/screens/about_screen.dart';
import 'package:tarot_mini_app/screens/card_detail_screen.dart';
import 'package:tarot_mini_app/screens/home_screen.dart';
import 'package:tarot_mini_app/screens/major_arcana_screen.dart';
import 'package:tarot_mini_app/screens/minor_arcana_screen.dart';
import 'package:tarot_mini_app/screens/settings_screen.dart';
import 'package:tarot_mini_app/screens/suit_selector_screen.dart';

class AppRouter {
  static Map<String, dynamic> _extractArgs(RouteSettings settings) {
    final args = settings.arguments;
    if (args is Map<String, dynamic>) return args;
    throw ArgumentError('Expected Map<String, dynamic> in route arguments');
  }

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/about':
        return MaterialPageRoute(builder: (_) => const AboutScreen());
      case '/settings':
        return MaterialPageRoute(builder: (_) => const SettingsScreen());      
      case '/major':
        final deck = _extractArgs(settings)['deck'];
        return MaterialPageRoute(
          builder: (_) => MajorArcanaScreen(deck: deck),
        );
      case '/suits':
        return MaterialPageRoute(
          builder: (_) => SuitSelectorScreen(),
        );        
      case '/minor':
        final deck = _extractArgs(settings)['deck'];
        final suit = _extractArgs(settings)['suit'];
        return MaterialPageRoute(
          builder: (_) => MinorArcanaScreen(deck: deck, suit: suit),
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
