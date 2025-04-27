import 'package:tarot_mini_app/services/base_service.dart';
import 'package:tarot_mini_app/models/suit.dart';
import 'api_client.dart';

class SuitService extends BaseService {
  final ApiClient _client = ApiClient();

  /// Public method that fetches suits with caching
  Future<List<Suit>> fetchSuits() =>
      fetchWithCache('suits', () => _fetchSuits());

  /// Private method that actually calls the API
  Future<List<Suit>> _fetchSuits() async {
    final jsonList = await _client.getList('/suits');
    return jsonList.map((json) => Suit.fromJson(json)).toList();
  }
}
