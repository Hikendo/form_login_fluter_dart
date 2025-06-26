import 'dart:convert'; // Importa librería para convertir datos entre JSON y objetos Dart.
import 'package:http/http.dart'
    as http; // Importa la librería http para hacer peticiones web.
import 'package:mi_app/interfaces/OrdenCompraModel.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Permite guardar y recuperar datos localmente.

class OrdenCompraService {
  // Define la clase para manejar órdenes de compra.
  final String _baseUrl = 'http://127.0.0.1:8000/api'; // URL base de la API.

  Future<String?> _getToken() async {
    // Método privado para obtener el token guardado.
    final prefs =
        await SharedPreferences.getInstance(); // Obtiene instancia de SharedPreferences.
    return prefs.getString(
      'auth_token',
    ); // Retorna el token almacenado (o null si no existe).
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
      print('🟡 Respuesta completa de la API ordenes: ${jsonEncode(data)}');

      if (response.statusCode == 200 && data['status'] == true) {
        final List<dynamic> rawList = data['items']['data'] ?? [];

        final ordenes = rawList
            .map((item) => OrdenCompraModel.fromJson(item))
            .toList();

        return {
          'success': true,
          'items': ordenes, // ✅ ahora es una lista de objetos OrdenCompraModel
        };
      } else {
        return {'success': false, 'message': data['message'] ?? 'Error'};
      }
    } catch (e) {
      print('🔴 Error al obtener órdenes: $e');
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> fetchOrdenCompraById(int id) async {
    // Método para obtener una orden por su ID.
    final token = await _getToken(); // Obtiene el token de autenticación.
    final url = Uri.parse(
      '$_baseUrl/ordenes_compra/$id',
    ); // Construye la URL para la orden específica.

    try {
      final response = await http.get(
        // Realiza una petición GET a la API.
        url,
        headers: {
          'Accept': 'application/json', // Solicita respuesta en formato JSON.
          'Authorization': 'Bearer $token', // Envía el token en la cabecera.
        },
      );

      final data = jsonDecode(response.body); // Decodifica la respuesta JSON.
      if (response.statusCode == 200 && data['status'] == true) {
        // Si la respuesta es exitosa y el status es true...
        return {
          'success': true,
          'item': data['items'],
        }; // Retorna éxito y la orden encontrada.
      } else {
        return {
          'success': false,
          'message': data['message'] ?? 'Error',
        }; // Retorna error y mensaje.
      }
    } catch (e) {
      return {
        'success': false,
        'message': e.toString(),
      }; // Retorna error y mensaje de excepción.
    }
  }
}
