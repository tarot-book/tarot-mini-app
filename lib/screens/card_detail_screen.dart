// file: lib/screens/card_detail_screen.dart

import 'package:flutter/material.dart';
import 'package:tarot_mini_app/models/arcana_type.dart';
import 'package:tarot_mini_app/models/card.dart';
import 'package:tarot_mini_app/models/meaning.dart';
import 'package:tarot_mini_app/models/source.dart';
import 'package:tarot_mini_app/services/card_service.dart';
import 'package:tarot_mini_app/services/meaning_service.dart';
import 'package:tarot_mini_app/services/source_service.dart';
import 'package:tarot_mini_app/theme/app_layout.dart';
import 'package:tarot_mini_app/widgets/cards/card_detail.dart';
import 'package:tarot_mini_app/widgets/layout/page_layout.dart';

const noMeaningText = 'Интерпретация отсутствует';

// Data model for card details screen, containing card info, sources, and meanings
class CardDetailData {
  final FullCardData card;
  final List<Source> sources;
  final CardMeanings meanings;

  CardDetailData({
    required this.card,
    required this.sources,
    required this.meanings,
  });
}

// Stateful widget for displaying card details
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
  int _selectedSourceIndex = 0;
  late Future<CardDetailData> _dataFuture;

  FullCardData? _card;
  List<Source>? _sources;

  @override
  void initState() {
    super.initState();
    _dataFuture = _loadData();
  }

  // Somewhere in your State или в отдельном утильном файле:
  int? _findMeaningId(
    List<CardMeaningRef> list,
    int sourceId,
    CardPosition position,
  ) {
    final matches = list.where(
      (m) => m.source == sourceId && m.position == position,
    );
    return matches.isEmpty ? null : matches.first.id;
  }

  // Helper method: load card & sources once, then fetch meanings each time
  Future<CardDetailData> _loadData() async {
    // Load card and sources only on first call
    if (_card == null || _sources == null) {
      _card =
          widget.arcanaType == ArcanaType.major
              ? await CardService().fetchMajorCardDetail(widget.cardId)
              : await CardService().fetchMinorCardDetail(widget.cardId);

      _sources = await SourceService().fetchSources();
      if (_sources!.isEmpty) {
        throw NoSourcesException();
      }
    }

    // Use existing card and sources
    final card = _card!;
    final sources = _sources!;

    // Select current source by index
    final src = sources[_selectedSourceIndex];

    // Find IDs for straight and reversed interpretations
    final straightId = _findMeaningId(
      card.meanings,
      src.id,
      CardPosition.straight,
    );
    final revertedId = _findMeaningId(
      card.meanings,
      src.id,
      CardPosition.reverted,
    );

    // Fetch meanings using service
    CardMeaningService cms = CardMeaningService();
    final meanings =
        widget.arcanaType == ArcanaType.major
            ? await cms.fetchMajorCardMeanings(straightId, revertedId)
            : await cms.fetchMinorCardMeanings(straightId, revertedId);

    return CardDetailData(card: card, sources: sources, meanings: meanings);
  }

  // Builds the error UI when something goes wrong
  Widget _buildErrorWidget(Object? error) {
    final String message;
    if (error is NoSourcesException) {
      message = error.toString();
    } else {
      message = 'An error occurred while loading data:\n$error';
    }
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(message, textAlign: TextAlign.center),
            const SizedBox(height: 16),
            ElevatedButton(onPressed: _retry, child: const Text('Retry')),
          ],
        ),
      ),
    );
  }

  // Retries data loading by resetting the future
  void _retry() {
    setState(() {
      _dataFuture = _loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<CardDetailData>(
      future: _dataFuture,
      builder: (context, snapshot) {
        Widget body;
        String? title;

        // Show loading indicator while waiting
        if (snapshot.connectionState != ConnectionState.done) {
          body = const Center(child: CircularProgressIndicator());
        }
        // Show error UI if an error occurred
        else if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(),
            body: _buildErrorWidget(snapshot.error),
          );
        }
        // Show content when data is loaded successfully
        else {
          final data = snapshot.data!;
          title = data.card.name;
          final sourceNames = data.sources.map((s) => s.name).toList();

          body = SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isWide =
                    constraints.maxWidth >= AppLayout.maxParagraphWidth;
                final content = ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 800),
                  child:
                      isWide
                          ? CardDetailWide(
                            imageUrl: data.card.imageUrl,
                            sources: sourceNames,
                            selectedIndex: _selectedSourceIndex,
                            onSourceChanged:
                                (i) => setState(() {
                                  _selectedSourceIndex = i;
                                  // Reload meanings for new source
                                  _dataFuture = _loadData();
                                }),
                            straightMeaning:
                                data.meanings.straight?.text ?? noMeaningText,
                            reversedMeaning:
                                data.meanings.reverted?.text ?? noMeaningText,
                          )
                          : CardDetailNarrow(
                            imageUrl: data.card.imageUrl,
                            cardName: data.card.name,
                            sources: sourceNames,
                            selectedIndex: _selectedSourceIndex,
                            onSourceChanged:
                                (i) => setState(() {
                                  _selectedSourceIndex = i;
                                  // Reload meanings for new source
                                  _dataFuture = _loadData();
                                }),
                            straightMeaning:
                                data.meanings.straight?.text ?? noMeaningText,
                            reversedMeaning:
                                data.meanings.reverted?.text ?? noMeaningText,
                          ),
                );
                return Center(child: content);
              },
            ),
          );
        }

        return Scaffold(
          appBar: AppBar(title: title != null ? Text(title) : null),
          body: PageLayout(child: body),
        );
      },
    );
  }
}
