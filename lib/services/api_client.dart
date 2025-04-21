import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiClient {
  final String _baseUrl;
  final String _username;
  final String _password;

  ApiClient()
      : _baseUrl = dotenv.env['API_BASE_URL'] ?? '',
        _username = dotenv.env['API_USERNAME'] ?? '',
        _password = dotenv.env['API_PASSWORD'] ?? '';

  Future<List<dynamic>> getList(String endpoint) async {
    final url = Uri.parse('$_baseUrl$endpoint');
    final headers = _buildHeaders();
    final response = await http.get(url, headers: headers);
    _handleErrors(response);
    return jsonDecode(response.body);
  }

  Map<String, String> _buildHeaders() {
    final auth = 'Basic ${base64Encode(utf8.encode('$_username:$_password'))}';
    return {
      'Authorization': auth,
      'Accept': 'application/json',
    };
  }

  void _handleErrors(http.Response response) {
    if (response.statusCode >= 400) {
      throw Exception('API error: ${response.statusCode} ${response.body}');
    }
  }

}
