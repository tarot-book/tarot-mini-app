import 'package:flutter/material.dart';
import 'package:tarot_mini_app/screens/deck_selector_screen.dart';
import '../widgets/home/actions_menu.dart';



class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tarot Mini-App')),
      body: 
      
      
 Center(
  child: ConstrainedBox(
    constraints: const BoxConstraints(maxWidth: 1000),
    child: Material(
      color: Colors.grey[850], // или Theme.of(context).colorScheme.surface
      borderRadius: BorderRadius.circular(24),
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: DeckSelectorScreen(),
            ),
            SizedBox(height: 16),
            ActionsMenu(), // здесь ripple будет работать
          ],
        ),
      ),
    ),
  ),
),




    );
  }
}


class RippleTest extends StatelessWidget {
  const RippleTest({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.grey[850],
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          splashColor: Colors.amber.withOpacity(0.3),
          highlightColor: Colors.amber.withOpacity(0.1),
          onTap: () => debugPrint('Tapped!'),
          child: const Padding(
            padding: EdgeInsets.all(24),
            child: Text('Нажми на меня', style: TextStyle(color: Colors.white)),
          ),
        ),
      ),
    );
  }
}
