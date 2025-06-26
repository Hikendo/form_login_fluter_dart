import 'package:flutter/material.dart'; // Importa el paquete principal de Flutter.
import 'package:mi_app/const/constants_app.dart'; // Importa las constantes de la app (ruta de la imagen).
import 'package:mi_app/views/login/forms/form_login.dart'; // Importa el formulario de login.
import 'package:mi_app/widgets/imagen_app.dart'; // Importa el widget personalizado para mostrar imágenes.

class LoginScreen extends StatelessWidget {
  // Define la pantalla de login como un widget sin estado.
  const LoginScreen({Key? key}) : super(key: key); // Constructor de la clase.

  @override
  Widget build(BuildContext context) {
    // Método que construye la interfaz de usuario.
    return Scaffold(
      // Widget base que proporciona la estructura visual.
      body: Center(
        // Centra el contenido en la pantalla.
        child: SingleChildScrollView(
          // Permite desplazar el contenido si es necesario.
          padding: const EdgeInsets.all(
            24.0,
          ), // Agrega padding alrededor del contenido.
          child: Column(
            // Organiza los widgets en una columna vertical.
            mainAxisAlignment:
                MainAxisAlignment.center, // Centra los elementos verticalmente.
            children: [
              ImagenApp(
                imagePath: dimankaLogo,
              ), // Muestra la imagen del logo usando el widget personalizado.
              const SizedBox(
                height: 32,
              ), // Espacio vertical entre la imagen y el formulario.
              // Formulario de login
              Card(
                // Muestra el formulario dentro de una tarjeta con sombra.
                elevation: 5, // Sombra de la tarjeta.
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    16,
                  ), // Bordes redondeados de la tarjeta.
                ),
                child: FormLogin(
                  key: const Key('form_login'),
                ), // Inserta el formulario de login.
              ),
            ],
          ),
        ),
      ),
    );
  }
}
// Este widget representa la pantalla de inicio de sesión de la aplicación.
// Utiliza un Scaffold para la estructura básica y un SingleChildScrollView para permitir el desplazamiento.
// Contiene un logo y un formulario de inicio de sesión dentro de una tarjeta estilizada.