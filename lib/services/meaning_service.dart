import 'package:tarot_mini_app/models/meaning.dart';
import 'package:tarot_mini_app/services/api_client.dart';
import 'package:tarot_mini_app/services/base_service.dart';

class CardMeaningService extends BaseService {
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

  /// Private helper that loads straight and reversed meanings
  Future<CardMeanings> _fetchCardMeanings(
    int? idStraight,
    int? idReverted,
    Future<CardMeaning> Function(int) detailFetcher,
  ) async {
    CardMeaning? straight;
    CardMeaning? reverted;

    if (idStraight != null && idReverted != null) {
      final results = await Future.wait([
        detailFetcher(idStraight),
        detailFetcher(idReverted),
      ]);
      straight = results[0];
      reverted = results[1];
    } else {
      if (idStraight != null) {
        straight = await detailFetcher(idStraight);
      }
      if (idReverted != null) {
        reverted = await detailFetcher(idReverted);
      }
    }

    return CardMeanings(straight: straight, reverted: reverted);
  }

  /// Fetch detail for a major arcana card meaning (cached)
  Future<CardMeaning> fetchMajorCardDetail(int id) =>
      fetchWithCache('majorMeaning:$id', () => _fetchMajorCardDetail(id));

  /// Fetch detail for a minor arcana card meaning (cached)
  Future<CardMeaning> fetchMinorCardDetail(int id) =>
      fetchWithCache('minorMeaning:$id', () => _fetchMinorCardDetail(id));

  /// Actual API call for major card meaning
  Future<CardMeaning> _fetchMajorCardDetail(int id) async {
    final data = await _client.getObject('/meanings/major/$id');
    return CardMeaning.fromJson(data);
  }

  /// Actual API call for minor card meaning
  Future<CardMeaning> _fetchMinorCardDetail(int id) async {
    final data = await _client.getObject('/meanings/minor/$id');
    return CardMeaning.fromJson(data);
  }
}
