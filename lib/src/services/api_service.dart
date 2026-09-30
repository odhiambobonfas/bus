import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://your-backend-url.com/api'; // Replace with your backend API

  // Generic GET request
  static Future<dynamic> get(String endpoint) async {
    final url = Uri.parse('$baseUrl/$endpoint');

    try {
      final response = await http.get(url);
      return _processResponse(response);
    } catch (e) {
      throw Exception('GET request failed: $e');
    }
  }

  // Generic POST request
  static Future<dynamic> post(String endpoint, Map<String, dynamic> data) async {
    final url = Uri.parse('$baseUrl/$endpoint');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );
      return _processResponse(response);
    } catch (e) {
      throw Exception('POST request failed: $e');
    }
  }

  // Generic PUT request
  static Future<dynamic> put(String endpoint, Map<String, dynamic> data) async {
    final url = Uri.parse('$baseUrl/$endpoint');

    try {
      final response = await http.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );
      return _processResponse(response);
    } catch (e) {
      throw Exception('PUT request failed: $e');
    }
  }

  // Generic DELETE request
  static Future<dynamic> delete(String endpoint) async {
    final url = Uri.parse('$baseUrl/$endpoint');

    try {
      final response = await http.delete(url);
      return _processResponse(response);
    } catch (e) {
      throw Exception('DELETE request failed: $e');
    }
  }

  // Handle API responses
  static dynamic _processResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return jsonDecode(response.body);
    } else {
      throw Exception(
        'API Error: ${response.statusCode} - ${response.body}',
      );
    }
  }
}
