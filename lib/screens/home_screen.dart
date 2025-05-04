import 'package:flutter/material.dart';
import 'package:tarot_mini_app/constants/app_constants.dart';
import 'package:tarot_mini_app/screens/deck_selector_screen.dart';
import 'package:tarot_mini_app/theme/app_layout.dart';
import 'package:tarot_mini_app/widgets/home/appbar.dart';
import 'package:tarot_mini_app/widgets/layout/page_layout.dart';

import '../widgets/home/actions_menu.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isNarrow = width < AppLayout.narrowScreenSize;

    return Scaffold(
      appBar: const MainAppBar(title: AppConstants.appTitle),

      body: PageLayout(
        child: ListView(
          // адаптивный padding
          padding: EdgeInsets.all(isNarrow ? AppLayout.horizontalPadding : 32),
          shrinkWrap: true,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isNarrow ? 8 : AppLayout.horizontalPadding,
                vertical: 8,
              ),
              child: DeckSelectorScreen(),
            ),
            const SizedBox(height: 16),
            const ActionsMenu(),
          ],
        ),
      ),
    );
  }
}
