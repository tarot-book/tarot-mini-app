import 'package:flutter/material.dart';
import 'package:tarot_mini_app/services/telegram_service.dart';

import '../services/logger_service.dart';


class TelegramUserProvider extends ChangeNotifier {
  String? userId;
  String? username;
  String? firstName;
  String? lastName;

  bool get isLoaded => userId != null;

  /// Инициализация пользователя
  Future<void> loadUser() async {
    try {
      userId = TelegramWebAppService.getUserId();
      username = TelegramWebAppService.getUsername();
      firstName = TelegramWebAppService.getFirstName();
      lastName = TelegramWebAppService.getLastName();
      notifyListeners();
      logger.i('Telegram user loaded: id=$userId, username=$username, firstName=$firstName');
    } catch (e) {
      logger.e('Failed to load Telegram user: $e');
    }
  }
}
