import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
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
      title: 'Tarot Mini-App',
      theme: appTheme,
      home: const HomeScreen(),
    );
  }
}
