import 'package:flutter/material.dart';
import 'routes/app_routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // MaterialApp es el widget raíz de la aplicación Flutter.
    // Proporciona temas, rutas y otras configuraciones globales.
    return MaterialApp(
      title:
          'Flutter Demo', // Título de la app (usado por algunos sistemas operativos).
      theme: ThemeData(
        // Define el tema visual de la app.
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ), // Paleta de colores basada en un color semilla.
      ),
      initialRoute: AppRoutes.login, // Ruta inicial al arrancar la app.
      onGenerateRoute:
          AppRoutes.generateRoute, // Función para generar rutas dinámicamente.
    );
  }
}
