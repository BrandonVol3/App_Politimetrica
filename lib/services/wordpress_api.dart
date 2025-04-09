import 'package:http/http.dart' as http;
import 'dart:convert';

class WordPressAPI {
  static const String baseUrl = 'https://marcaweb.net/politimetrica/wp-json/wp/v2';

  static Future<List<dynamic>> getPosts() async {
    final response = await http.get(
      Uri.parse('$baseUrl/posts?_embed'),
      headers: {'Accept': 'application/json'},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Error al cargar los datos: ${response.statusCode}');
    }
  }
}