import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tarot_mini_app/models/suit.dart';
import 'package:tarot_mini_app/providers/app_state.dart';
import 'package:tarot_mini_app/services/suit_service.dart';
import 'package:tarot_mini_app/widgets/layout/page_layout.dart';
import 'package:tarot_mini_app/widgets/suits/suits_list_view.dart';

class SuitSelectorScreen extends StatefulWidget {
  const SuitSelectorScreen({super.key});

  @override
  SuitSelectorScreenState createState() => SuitSelectorScreenState();
}

class SuitSelectorScreenState extends State<SuitSelectorScreen> {
  late Future<List<Suit>> _futureSuits;

  @override
  void initState() {
    super.initState();
    _futureSuits = SuitService().fetchSuits();
  }

  @override
  Widget build(BuildContext context) {
    final deck = Provider.of<AppState>(context).selectedDeck;

    return Scaffold(
      appBar: AppBar(title: const Text('Выберите масть')),
      body: PageLayout(
        child: FutureBuilder<List<Suit>>(
          future: _futureSuits,
          builder: (ctx, snap) {
            if (snap.connectionState != ConnectionState.done) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snap.hasError) {
              return Center(child: Text('Ошибка: ${snap.error}'));
            }

            if (!(deck?.hasMinorCards ?? false)) {
              return Center(
                child: Text('В колоде ${deck?.name ?? ""} отсутствуют Младшие Арканы.'),
              );
            }

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: SuitListView(
                deck: deck!,
                suits: snap.data!,
              ),
            );
          },
        ),
      ),
    );
  }
}
