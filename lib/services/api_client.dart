import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tarot_mini_app/constants/app_constants.dart';

class ApiClient {
  final String _baseUrl;

  ApiClient() : _baseUrl = AppConstants.apiBaseUrl;

  Future<List<dynamic>> getList(String endpoint) async {
    final url = Uri.parse('$_baseUrl$endpoint');
    final headers = _buildHeaders();
    final response = await http.get(url, headers: headers);
    _handleErrors(response);
    return jsonDecode(response.body);
  }

  Future<Map<String, dynamic>> getObject(String endpoint) async {
    final url = Uri.parse('$_baseUrl$endpoint');
    final headers = _buildHeaders();
    final response = await http.get(url, headers: headers);
    _handleErrors(response);
    return jsonDecode(response.body) as Map<String, dynamic>;
  }

  Map<String, String> _buildHeaders() {
    return {
      'Accept': 'application/json',
    };
  }

  void _handleErrors(http.Response response) {
    if (response.statusCode >= 400) {
      throw Exception('API error: ${response.statusCode} ${response.body}');
    }
  }
}
