import 'package:flutter/material.dart'; // Importa el paquete principal de Flutter para widgets y navegación.
import '../views/login/login_page.dart'; // Importa la pantalla de login.
import '../views/ordenes/ordenes_compra.dart'; // Importa la pantalla de órdenes de compra.

class AppRoutes {
  static const String login =
      '/login'; // Ruta constante para la pantalla de login.
  static const String ordenesCompra =
      '/ordenes-de-compra'; // Ruta constante para la pantalla de órdenes de compra.

  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Método estático que genera rutas dinámicamente según la configuración recibida.
    switch (settings.name) {
      // Evalúa el nombre de la ruta solicitada.
      case login: // Si la ruta es '/login'...
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        ); // ...retorna la pantalla de login.

      case ordenesCompra: // Si la ruta es '/ordenes-de-compra'...
        return MaterialPageRoute(
          builder: (_) => const OrdenesCompraScreen(),
        ); // ...retorna la pantalla de órdenes de compra.

      default: // Si la ruta no coincide con ninguna definida...
        return MaterialPageRoute(
          // ...retorna una pantalla genérica de error.
          builder: (_) => Scaffold(
            body: Center(
              child: Text('Ruta no encontrada: ${settings.name}'),
            ), // Muestra mensaje de ruta no encontrada.
          ),
        );
    }
  }
}
// Este archivo define las rutas de la aplicación y cómo se generan dinámicamente.
// Utiliza el patrón de diseño de rutas de Flutter para navegar entre diferentes pantallas.