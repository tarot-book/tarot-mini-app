// lib/services/telegram_service.dart

import 'package:telegram_web_app/telegram_web_app.dart';
import 'package:tarot_mini_app/services/logger_service.dart';

/// Service to interact with the Telegram Web App SDK
class TelegramService {
  // Singleton instance of the Telegram Web App bridge
  final TelegramWebApp _tg = TelegramWebApp.instance;

  /// Initializes the Telegram WebApp:
  /// - Signals readiness
  /// - Expands to available height
  /// - Disables vertical swipe-to-close
  void init() {
    if (_tg.isSupported) {
      _tg.ready();                    // INFORM TELEGRAM THAT WEBAPP IS READY ([pub.dev](https://pub.dev/documentation/telegram_web_app/latest/telegram_web_app/TelegramWebApp-class.html))
      _tg.expand();                   // EXPAND TO MAXIMUM HEIGHT ([pub.dev](https://pub.dev/documentation/telegram_web_app/latest/telegram_web_app/TelegramWebApp-class.html))
      _tg.disableVerticalSwipes();    // DISABLE SWIPE-TO-CLOSE ([pub.dev](https://pub.dev/documentation/telegram_web_app/latest/telegram_web_app/TelegramWebApp-class.html))

      logger.i('Telegram WebApp initialized: expanded and swipe-to-close disabled');
    } else {
      logger.w('Telegram WebApp is not supported in this context');
    }
  }

  /// Returns true if running inside a Telegram WebApp
  bool get isInsideTelegram => _tg.isSupported;  // CHECKS SUPPORT ([pub.dev](https://pub.dev/documentation/telegram_web_app/latest/telegram_web_app/TelegramWebApp-class.html))

  /// Raw “unsafe” initialization data from Telegram
  WebAppInitData? get initDataUnsafe => _tg.initDataUnsafe;  // TYPE: WebAppInitData? ([pub.dev](https://pub.dev/documentation/telegram_web_app/latest/telegram_web_app/TelegramWebApp-class.html))

  /// Telegram user ID as string, or null if unavailable
  String? get userId => initDataUnsafe?.user?.id.toString();

  /// Telegram username, or null if unavailable
  String? get username => initDataUnsafe?.user?.username;

  /// Telegram first name, or null if unavailable
  String? get firstName => initDataUnsafe?.user?.firstName;

  /// Telegram last name, or null if unavailable
  String? get lastName => initDataUnsafe?.user?.lastName;
}
