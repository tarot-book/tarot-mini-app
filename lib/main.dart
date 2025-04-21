import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:tarot_mini_app/screens/major_arcana_screen.dart';
import 'package:tarot_mini_app/screens/minor_arcana_screen.dart';
import 'screens/home_screen.dart';
import 'theme/theme.dart';

Future<void> main() async {
  await dotenv.load(); // Загрузка .env перед запуском
  runApp(const TarotMiniApp());
}

class TarotMiniApp extends StatelessWidget {
  const TarotMiniApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tarot App',
      theme: appTheme,
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/major': (context) => const MajorArcanaScreen(),
        '/minor': (context) => const MinorArcanaScreen(),
      },
    );
  }
}
