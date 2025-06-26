import 'dart:convert'; // Importa librería para convertir datos entre JSON y objetos Dart.
import 'package:http/http.dart'
    as http; // Importa la librería http para hacer peticiones web.
import 'package:shared_preferences/shared_preferences.dart'; // Permite guardar datos localmente en el dispositivo.

class AuthService {
  // Define la clase AuthService para manejar autenticación.
  final String _baseUrl =
      'http://127.0.0.1:8000/api'; // URL base de la API (ajusta según tu entorno).

  Future<Map<String, dynamic>> login(String email, String password) async {
    // Método asíncrono para iniciar sesión.
    final url = Uri.parse(
      '$_baseUrl/auth/login',
    ); // Construye la URL para el endpoint de login.

    try {
      final response = await http.post(
        // Realiza una petición POST al endpoint de login.
        url,
        headers: {
          'Content-Type': 'application/json', // Indica que el cuerpo es JSON.
          'Accept': 'application/json', // Solicita respuesta en formato JSON.
        },
        body: jsonEncode({
          'email': email,
          'password': password,
        }), // Convierte los datos a JSON.
      );

      if (!response.headers['content-type']!.contains('application/json')) {
        // Verifica que la respuesta sea JSON.
        throw Exception(
          'Respuesta no es JSON: ${response.body}',
        ); // Lanza excepción si no es JSON.
      }

      final data = jsonDecode(response.body); // Decodifica la respuesta JSON.
      if (response.statusCode == 200) {
        // Si la respuesta es exitosa (código 200)...
        final token = data['items']['token']; // Extrae el token del JSON.
        await _saveToken(token); // Guarda el token localmente.

        return {
          'success': true,
          'user': data['items']['user'],
          'token': token,
        }; // Retorna éxito, usuario y token.
      } else {
        return {
          'success': false,
          'message':
              data['message'] ??
              'Error desconocido', // Retorna mensaje de error.
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Error de red: ${e.toString()}',
      }; // Maneja errores de red o excepciones.
    }
  }

  Future<void> _saveToken(String token) async {
    // Método privado para guardar el token.
    final prefs =
        await SharedPreferences.getInstance(); // Obtiene instancia de SharedPreferences.
    await prefs.setString(
      'auth_token',
      token,
    ); // Guarda el token bajo la clave 'auth_token'.
  }

  Future<String?> getToken() async {
    // Método para obtener el token guardado.
    final prefs =
        await SharedPreferences.getInstance(); // Obtiene instancia de SharedPreferences.
    return prefs.getString(
      'auth_token',
    ); // Retorna el token almacenado (o null si no existe).
  }

  Future<void> logout() async {
    // Método para eliminar el token (cerrar sesión).
    final prefs =
        await SharedPreferences.getInstance(); // Obtiene instancia de SharedPreferences.
    await prefs.remove('auth_token'); // Elimina el token guardado.
  }
}
