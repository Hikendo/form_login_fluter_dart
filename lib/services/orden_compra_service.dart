import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class OrdenCompraService {
  final String _baseUrl = 'http://127.0.0.1:8000/api';

  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  Future<Map<String, dynamic>> fetchOrdenesCompra({String query = ''}) async {
    final token = await _getToken();
    final url = Uri.parse('$_baseUrl/ordenes_compra?query=$query');

    try {
      final response = await http.get(
        url,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      final data = jsonDecode(response.body);

      // 🔥 Imprime toda la respuesta para debugging
      print('🟡 Respuesta completa de la API ordenes: ${jsonEncode(data)}');

      if (response.statusCode == 200 && data['status'] == true) {
        return {'success': true, 'items': data['items']};
      } else {
        return {'success': false, 'message': data['message'] ?? 'Error'};
      }
    } catch (e) {
      print('🔴 Error al obtener órdenes: $e');
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> fetchOrdenCompraById(int id) async {
    final token = await _getToken();
    final url = Uri.parse('$_baseUrl/ordenes_compra/$id');

    try {
      final response = await http.get(
        url,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      final data = jsonDecode(response.body);
      if (response.statusCode == 200 && data['status'] == true) {
        return {'success': true, 'item': data['items']};
      } else {
        return {'success': false, 'message': data['message'] ?? 'Error'};
      }
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }
}
