import '../models/source.dart';
import 'api_client.dart';

class SourceService {
  final ApiClient _client = ApiClient();

  Future<List<Source>> fetchSources() async {
    final jsonList = await _client.getList('/sources');
    return jsonList.map((json) => Source.fromJson(json)).toList();
  }
}
