import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final String _baseUrl =
      'http://127.0.0.1:8000/api'; // Cambiar a IP real si usas emulador físico

  Future<Map<String, dynamic>> login(String email, String password) async {
    final url = Uri.parse('$_baseUrl/auth/login');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (!response.headers['content-type']!.contains('application/json')) {
        throw Exception('Respuesta no es JSON: ${response.body}');
      }

      final data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        final token = data['items']['token'];
        await _saveToken(token);

        return {'success': true, 'user': data['items']['user'], 'token': token};
      } else {
        return {
          'success': false,
          'message': data['message'] ?? 'Error desconocido',
        };
      }
    } catch (e) {
      return {'success': false, 'message': 'Error de red: ${e.toString()}'};
    }
  }

  Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
  }
}
