import 'package:flutter/material.dart';
import 'package:tarot_mini_app/screens/deck_selector_screen.dart';
import 'package:tarot_mini_app/widgets/layout/page_layout.dart';

import '../widgets/home/actions_menu.dart';

const title = 'Азбука Таро';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(title)),
      body: PageLayout(
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
    );
  }
}
