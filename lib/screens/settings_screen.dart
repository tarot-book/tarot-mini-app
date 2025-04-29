import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tarot_mini_app/providers/telegram_user_provider.dart';
import 'package:tarot_mini_app/widgets/layout/page_layout.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final telegramUser = context.watch<TelegramUserProvider>();

    final bool isTelegramConnected = telegramUser.isLoaded;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Настройки'),
      ),
      body: IntrinsicHeight(
        child: PageLayout(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.settings_outlined,
                    size: 64,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    isTelegramConnected
                        ? 'Пользователь: ${telegramUser.firstName ?? telegramUser.username ?? 'Неизвестный'}'
                        : 'Платформа Telegram не подключена.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.grey,
                        ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
