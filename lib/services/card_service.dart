import 'package:tarot_mini_app/models/card.dart';
import 'package:tarot_mini_app/models/major_card.dart';
import 'package:tarot_mini_app/models/minor_card.dart';
import 'package:tarot_mini_app/services/base_service.dart';

import 'api_client.dart';

class CardService extends BaseService {
  final ApiClient _client = ApiClient();

  Future<List<ArcanaCardData>> fetchMajorCards(int deckId) =>
      fetchWithCache('majorCards:$deckId', () => _fetchMajorCards(deckId));

  Future<FullCardData> fetchMajorCardDetail(int id) =>
      fetchWithCache('majorDetail:$id', () => _fetchMajorCardDetail(id));

  Future<List<ArcanaCardData>> fetchMinorCards(int deckId, int suitId) =>
      fetchWithCache(
        'minorCards:$deckId:$suitId',
        () => _fetchMinorCards(deckId, suitId),
      );

  Future<FullCardData> fetchMinorCardDetail(int id) =>
      fetchWithCache('minorDetail:$id', () => _fetchMinorCardDetail(id));

  // Private methods to actually load data from API
  Future<List<ArcanaCardData>> _fetchMajorCards(int deckId) async {
    final data = await _client.getList('/cards/major?deckId=$deckId');
    return data
        .map((item) => MajorCard.fromJson(item) as ArcanaCardData)
        .toList();
  }

  Future<FullCardData> _fetchMajorCardDetail(int id) async {
    final data = await _client.getObject('/cards/major/$id');
    return MajorCardDetail.fromJson(data);
  }

  Future<List<ArcanaCardData>> _fetchMinorCards(int deckId, int suitId) async {
    final data = await _client.getList('/cards/minor?deckId=$deckId');
    return data
        .where((item) => item['suit'] == suitId)
        .map((item) => MinorCard.fromJson(item) as ArcanaCardData)
        .toList();
  }

  Future<FullCardData> _fetchMinorCardDetail(int id) async {
    final data = await _client.getObject('/cards/minor/$id');
    return MinorCardDetail.fromJson(data);
  }
}
