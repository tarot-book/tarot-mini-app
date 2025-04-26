import 'package:tarot_mini_app/models/suit.dart';
import 'api_client.dart';

class SuitService {
  final ApiClient _client = ApiClient();

  Future<List<Suit>> fetchSuits() async {
    final jsonList = await _client.getList('/suits');
    return jsonList.map((json) => Suit.fromJson(json)).toList();
  }
}
