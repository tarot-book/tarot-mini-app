import '../models/deck.dart';
import 'api_client.dart';

class DeckService {
  final ApiClient _client = ApiClient();

  Future<List<Deck>> fetchDecks() async {
    final jsonList = await _client.getList('/decks');
    return jsonList.map((json) => Deck.fromJson(json)).toList();
  }
}
