import 'package:flutter/material.dart';
import 'package:tarot_mini_app/models/arcana_type.dart';
import 'package:tarot_mini_app/models/card.dart';
import 'package:tarot_mini_app/models/source.dart';
import 'package:tarot_mini_app/services/card_service.dart';
import 'package:tarot_mini_app/services/source_service.dart';
import 'package:tarot_mini_app/widgets/cards/card_image.dart';
import 'package:tarot_mini_app/widgets/cards/meaning_tabs.dart';
import 'package:tarot_mini_app/widgets/sources/source_selector.dart';

class CardDetailScreen extends StatefulWidget {
  final int cardId;
  final ArcanaType arcanaType;

  const CardDetailScreen({
    super.key,
    required this.cardId,
    required this.arcanaType,
  });

  @override
  State<CardDetailScreen> createState() => _CardDetailScreenState();
}

class _CardDetailScreenState extends State<CardDetailScreen> {
  late final Future<FullCardData> _cardFuture;
  late final Future<List<Source>> _sourcesFuture;
  int _selectedSourceIndex = 0;

  @override
  void initState() {
    super.initState();
    _cardFuture =
        widget.arcanaType == ArcanaType.major
            ? CardService().fetchMajorCardDetail(widget.cardId)
            : CardService().fetchMinorCardDetail(widget.cardId);
    _sourcesFuture = SourceService().fetchSources();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: Future.wait([_cardFuture, _sourcesFuture]),
      builder: (context, snapshot) {
        String? title;
        Widget body;

        if (snapshot.connectionState != ConnectionState.done) {
          body = const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          body = Center(child: Text('Ошибка: \${snapshot.error}'));
        } else {
          final card = snapshot.data![0] as FullCardData;
          final sources = snapshot.data![1] as List<Source>;

          title = card.name;

          // TODO: replace placeholder texts with real data
          final int sourceId = sources[_selectedSourceIndex].id;
          final straightText = "Straight text";
          final revertedText = "Reverted text";
          body = SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isWide = constraints.maxWidth >= 768;
                return Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 800),
                    child:
                        isWide
                            ? Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 4,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      CardImage(imageUrl: card.imageUrl),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 24),
                                Expanded(
                                  flex: 6,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      SourceSelector(
                                        sources:
                                            sources.map((s) => s.name).toList(),
                                        selectedIndex: _selectedSourceIndex,
                                        onSourceChanged:
                                            (index) => setState(() {
                                              _selectedSourceIndex = index;
                                            }),
                                      ),
                                      const SizedBox(height: 16),
                                      MeaningTabs(
                                        straightMeaning: straightText,
                                        reversedMeaning: revertedText,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                            : Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CardImage(imageUrl: card.imageUrl),
                                const SizedBox(height: 24),
                                Text(
                                  card.name,
                                  style:
                                      Theme.of(context).textTheme.headlineLarge,
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 16),
                                SourceSelector(
                                  sources: sources.map((s) => s.name).toList(),
                                  selectedIndex: _selectedSourceIndex,
                                  onSourceChanged:
                                      (index) => setState(() {
                                        _selectedSourceIndex = index;
                                      }),
                                ),
                                const SizedBox(height: 16),
                                MeaningTabs(
                                  straightMeaning: straightText,
                                  reversedMeaning: revertedText,
                                ),
                              ],
                            ),
                  ),
                );
              },
            ),
          );
        }

        return Scaffold(
          appBar: AppBar(title: title != null ? Text(title) : null),
          body: body,
        );
      },
    );
  }
}
