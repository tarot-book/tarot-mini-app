// lib/services/telegram_service.dart
import 'dart:js_interop';

import 'package:tarot_mini_app/services/logger_service.dart';

@JS('Telegram.WebApp')
external WebApp get telegramWebApp;

@JS()
extension type WebApp(JSObject _) {
  /// Signals that the WebApp is ready to be used
  external void ready();

  /// Expands the WebApp to the maximum available height
  external void expand();

  /// Disables the vertical swipe‑to‑close behavior
  external void disableVerticalSwipes();

  /// Access raw initialization data
  external InitDataUnsafe get initDataUnsafe;
}

@JS()
extension type InitDataUnsafe(JSObject _) {
  external User get user;
}

@JS()
extension type User(JSObject _) {
  external int get id;
  external String get username;
  // ignore: non_constant_identifier_names
  external String get first_name;
  // ignore: non_constant_identifier_names
  external String get last_name;
}

class TelegramWebAppService {
  /// Initializes the Telegram Mini‑App SDK,
  /// expands the window and disables swipe‑to‑close
  static void init() {
    try {
      telegramWebApp.ready();
      telegramWebApp.expand();
      telegramWebApp.disableVerticalSwipes();
      logger.i('Telegram WebApp initialized!');
    } catch (e) {
      logger.e('Not inside Telegram WebApp or error initializing: $e');
    }
  }

  /// Returns the Telegram user ID, or null if unavailable
  static String? getUserId() {
    try {
      return telegramWebApp.initDataUnsafe.user.id.toString();
    } catch (_) {
      return null;
    }
  }

  /// Returns the Telegram username, or null if unavailable
  static String? getUsername() {
    try {
      return telegramWebApp.initDataUnsafe.user.username;
    } catch (_) {
      return null;
    }
  }

  /// Returns the Telegram user's first name, or null if unavailable
  static String? getFirstName() {
    try {
      return telegramWebApp.initDataUnsafe.user.first_name;
    } catch (_) {
      return null;
    }
  }

  /// Returns the Telegram user's last name, or null if unavailable
  static String? getLastName() {
    try {
      return telegramWebApp.initDataUnsafe.user.last_name;
    } catch (_) {
      return null;
    }
  }

  /// Checks if the code is running inside a Telegram WebApp context
  static bool isRunningInsideTelegram() {
    try {
      return telegramWebApp != null;
    } catch (_) {
      return false;
    }
  }
}
