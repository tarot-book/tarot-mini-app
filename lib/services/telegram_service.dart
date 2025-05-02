import 'dart:js_interop';

import 'package:tarot_mini_app/services/logger_service.dart';

@JS('Telegram.WebApp')
external WebApp get telegramWebApp;

@JS()
extension type WebApp(JSObject _) {
  external void ready();
  external void expand();
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
  static void init() {
    try {
      telegramWebApp.ready();
      telegramWebApp.expand();
      logger.i('Telegram WebApp initialized!');
    } catch (e) {
      logger.e('Not inside Telegram WebApp or error initializing: $e');
    }
  }

  static String? getUserId() {
    try {
      return telegramWebApp.initDataUnsafe.user.id.toString();
    } catch (e) {
      return null;
    }
  }

  static String? getUsername() {
    try {
      return telegramWebApp.initDataUnsafe.user.username;
    } catch (e) {
      return null;
    }
  }

  static String? getFirstName() {
    try {
      return telegramWebApp.initDataUnsafe.user.first_name;
    } catch (e) {
      return null;
    }
  }

  static String? getLastName() {
    try {
      return telegramWebApp.initDataUnsafe.user.last_name;
    } catch (e) {
      return null;
    }
  }

  static bool isRunningInsideTelegram() {
    try {
      return telegramWebApp != null;
    } catch (e) {
      return false;
    }
  }
}
