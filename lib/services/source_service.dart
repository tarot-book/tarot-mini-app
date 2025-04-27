import 'package:tarot_mini_app/services/base_service.dart';
import '../models/source.dart';
import 'api_client.dart';

class SourceService extends BaseService {
  final ApiClient _client = ApiClient();

  /// Public method that fetches sources with caching
  Future<List<Source>> fetchSources() =>
      fetchWithCache('sources', () => _fetchSources());

  /// Private method that actually calls the API
  Future<List<Source>> _fetchSources() async {
    final jsonList = await _client.getList('/sources');
    return jsonList.map((json) => Source.fromJson(json)).toList();
  }
}
