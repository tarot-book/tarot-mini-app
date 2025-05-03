// lib/providers/telegram_user_provider.dart

import 'package:flutter/material.dart';
import 'package:tarot_mini_app/services/telegram_service.dart';
import 'package:tarot_mini_app/services/logger_service.dart';

/// Provides Telegram user data to the widget tree
class TelegramUserProvider extends ChangeNotifier {
  final TelegramService _telegram = TelegramService();

  String? userId;
  String? username;
  String? firstName;
  String? lastName;

  /// Returns true once userId is loaded
  bool get isLoaded => userId != null;

  /// Loads the Telegram user data from WebApp initData
  Future<void> loadUser() async {
    try {
      userId    = _telegram.userId;
      username  = _telegram.username;
      firstName = _telegram.firstName;
      lastName  = _telegram.lastName;

      notifyListeners();
      logger.i(
        'Telegram user loaded: '
        'id=$userId, username=$username, firstName=$firstName, lastName=$lastName'
      );
    } catch (e) {
      logger.e('Failed to load Telegram user: $e');
    }
  }
}
