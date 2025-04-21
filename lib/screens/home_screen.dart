import 'package:flutter/material.dart';
import 'package:tarot_mini_app/widgets/arcana_menu_item.dart';
import 'deck_selector_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tarot Mini-App')),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: DeckSelectorScreen(),
          ),
          const Divider(thickness: 1),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Wrap(
                spacing: 16, // горизонтальный отступ между карточками
                runSpacing: 16, // вертикальный отступ при переносе
                children: [
                  SizedBox(
                    width: 300, // фиксированная ширина карточки
                    child: ArcanaMenuItem(
                      title: 'Старшие арканы',
                      imagePath: 'assets/images/fool.png',
                      onTap: () => Navigator.pushNamed(context, '/major'),
                    ),
                  ),
                  SizedBox(
                    width: 300,
                    child: ArcanaMenuItem(
                      title: 'Младшие арканы',
                      imagePath: 'assets/images/suits.png',
                      onTap: () => Navigator.pushNamed(context, '/minor'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
