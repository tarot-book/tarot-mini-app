import 'package:tarot_mini_app/services/base_service.dart';
import '../models/deck.dart';
import 'api_client.dart';

class DeckService extends BaseService {
  final ApiClient _client = ApiClient();

  // Public method with transparent caching
  Future<List<Deck>> fetchDecks() => fetchWithCache('decks', () => _fetchDecks());

  // Private method that actually calls the API
  Future<List<Deck>> _fetchDecks() async {
    final jsonList = await _client.getList('/decks');
    return jsonList.map((json) => Deck.fromJson(json)).toList();
  }
}
