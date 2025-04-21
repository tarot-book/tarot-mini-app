import 'package:flutter/material.dart';
import 'package:tarot_mini_app/widgets/arcana/arcana_menu_item.dart';

class ActionsMenu extends StatelessWidget {

  const ActionsMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Wrap(
        spacing: 16,
        runSpacing: 16,
        alignment: WrapAlignment.center,
        children: [
          ArcanaMenuItem(
            title: 'Старшие арканы',
            imagePath: 'assets/images/fool.png',
            onTap: () => Navigator.pushNamed(context, '/major'),
          ),
          ArcanaMenuItem(
            title: 'Младшие арканы',
            imagePath: 'assets/images/suits.png',
            onTap: () => Navigator.pushNamed(context, '/minor'),
          ),
        ],
      ),
    );
  }
}

