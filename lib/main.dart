import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:tarot_mini_app/providers/app_state.dart';
import 'package:tarot_mini_app/routes/app_router.dart';
import 'theme/theme.dart';

Future<void> main() async {
  await dotenv.load(); // Загрузка .env перед запуском
  runApp(
    ChangeNotifierProvider(
      create: (_) => AppState(),
      child: const TarotApp(),
    ),
  );  
}

class TarotApp extends StatelessWidget {
  const TarotApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tarot App',
      theme: appTheme,
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}
