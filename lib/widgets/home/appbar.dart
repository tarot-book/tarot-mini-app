import 'package:flutter/material.dart';


/// A common AppBar for the Tarot Mini-App screens
class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// Title text for the AppBar
  final String title;

  const MainAppBar({ 
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      centerTitle: true,
        
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            tooltip: 'About',
            onPressed: () {
              Navigator.of(context).pushNamed('/about');
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: 'Settings',
            onPressed: () {
              Navigator.of(context).pushNamed('/settings');
            },
          ),
        ],
    );
  }

  @override
  // Defines height of the AppBar
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
