import 'package:tarot_mini_app/models/arcana_card_data.dart';
import 'package:tarot_mini_app/models/card.dart';
import 'package:tarot_mini_app/models/major_card.dart';

import 'api_client.dart';

class CardService {
  final ApiClient _client = ApiClient();

  Future<List<ArcanaCardData>> fetchMajorCards(int deckId) async {
    final data = await _client.getList('/cards/major?deckId=$deckId');
    return data
        .map((item) => MajorCard.fromJson(item) as ArcanaCardData)
        .toList();
  }

  Future<FullCardData> fetchMajorCardDetail(int id) async {
    final data = await _client.getObject('/cards/major/$id');
    return MajorCardDetail.fromJson(data);
  }

  Future<FullCardData> fetchMinorCardDetail(int id) async {
    final data = await _client.getObject('/cards/minor/$id');
    return MinorCardDetail.fromJson(data);
  }

}
