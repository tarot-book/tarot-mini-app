import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tarot_mini_app/constants/app_constants.dart';
import 'package:tarot_mini_app/providers/app_state.dart';
import 'package:tarot_mini_app/providers/telegram_user_provider.dart';
import 'package:tarot_mini_app/routes/app_router.dart';
import 'package:tarot_mini_app/services/logger_service.dart';
import 'theme/theme.dart';

Future<void> main() async {
  logger.i('App started');
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppState()),
        ChangeNotifierProvider(create: (_) => TelegramUserProvider()..loadUser()),
      ],
      child: const TarotApp(),
    ),
  );
}

class TarotApp extends StatelessWidget {
  const TarotApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appTitle,
      theme: appTheme,
      onGenerateRoute: AppRouter.generateRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}
