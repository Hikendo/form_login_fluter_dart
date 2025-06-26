import 'package:flutter/material.dart';
import '../views/login/login_page.dart';
import '../views/ordenes/ordenes_compra.dart'; // Importa la nueva vista

class AppRoutes {
  static const String login = '/login';
  static const String ordenesCompra = '/ordenes-de-compra'; // Nueva ruta

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());

      case ordenesCompra: // Nueva ruta
        return MaterialPageRoute(builder: (_) => const OrdenesCompraScreen());

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('Ruta no encontrada: ${settings.name}')),
          ),
        );
    }
  }
}
