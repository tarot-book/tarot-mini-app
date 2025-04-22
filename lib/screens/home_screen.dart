import 'package:flutter/material.dart';
import 'package:tarot_mini_app/screens/deck_selector_screen.dart';
import 'package:tarot_mini_app/theme/app_layout.dart';

import '../widgets/home/actions_menu.dart';

const title = 'Азбука Таро';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(title)),
      body: Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.only(top: 32),
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: AppLayout.maxContentWidth,
            ),
            child: Material(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(18),
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: ListView(
                  padding: const EdgeInsets.all(32),
                  shrinkWrap: true,
                  children: const [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: DeckSelectorScreen(),
                    ),
                    SizedBox(height: 16),
                    ActionsMenu(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
