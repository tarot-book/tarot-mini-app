import 'package:tarot_mini_app/models/meaning.dart';
import 'package:tarot_mini_app/services/api_client.dart';

class CardMeaningService {
  // Underlying HTTP client, assumed available in this service
  final _client = ApiClient();

  /// Fetch meanings for a major arcana card, handling nullable IDs
  Future<CardMeanings> fetchMajorCardMeanings(
    int? idStraight,
    int? idReverted,
  ) {
    return _fetchCardMeanings(idStraight, idReverted, fetchMajorCardDetail);
  }

  /// Fetch meanings for a minor arcana card, handling nullable IDs
  Future<CardMeanings> fetchMinorCardMeanings(
    int? idStraight,
    int? idReverted,
  ) {
    return _fetchCardMeanings(idStraight, idReverted, fetchMinorCardDetail);
  }

  /// Private helper that loads straight and reversed meanings,
  /// using the provided detailFetcher function to load each by ID.
  Future<CardMeanings> _fetchCardMeanings(
    int? idStraight,
    int? idReverted,
    Future<CardMeaning> Function(int) detailFetcher,
  ) async {
    CardMeaning? straight;
    CardMeaning? reverted;

    // If both IDs are provided, fetch both in parallel
    if (idStraight != null && idReverted != null) {
      final results = await Future.wait([
        detailFetcher(idStraight),
        detailFetcher(idReverted),
      ]);
      straight = results[0];
      reverted = results[1];
    } else {
      // Otherwise fetch only the one that exists
      if (idStraight != null) {
        straight = await detailFetcher(idStraight);
      }
      if (idReverted != null) {
        reverted = await detailFetcher(idReverted);
      }
    }
    return CardMeanings(straight: straight, reverted: reverted);
  }

  // Example detail-fetchers:
  Future<CardMeaning> fetchMajorCardDetail(int id) async {
    final data = await _client.getObject('/meanings/major/$id');
    return CardMeaning.fromJson(data);
  }

  Future<CardMeaning> fetchMinorCardDetail(int id) async {
    final data = await _client.getObject('/meanings/minor/$id');
    return CardMeaning.fromJson(data);
  }
}
