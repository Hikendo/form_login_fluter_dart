import 'package:flutter/material.dart';
import 'package:mi_app/services/auth_service.dart';
import 'package:mi_app/views/ordenes/orden_compra_list_page.dart'; // ajusta según tu estructura

// Widget de formulario de login
class FormLogin extends StatefulWidget {
  const FormLogin({Key? key}) : super(key: key);

  @override
  State<FormLogin> createState() => _FormLoginState();
}

class _FormLoginState extends State<FormLogin> {
  // Clave global para el formulario
  final _formKey = GlobalKey<FormState>();
  // Controladores para los campos de texto
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  // Estado para mostrar/ocultar contraseña
  bool _obscurePassword = true;
  // Estado para mostrar indicador de carga
  bool _isLoading = false;

  // Instancia del servicio de autenticación
  final AuthService _authService = AuthService();

  @override
  void dispose() {
    // Liberar recursos de los controladores
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Función para manejar el envío del formulario
  Future<void> _submit() async {
    // Validar el formulario
    if (_formKey.currentState?.validate() ?? false) {
      setState(() => _isLoading = true);

      // Llamar al servicio de login
      final result = await _authService.login(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );

      setState(() => _isLoading = false);

      if (result['success']) {
        // Mostrar snackbar de éxito
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Inicio de sesión exitoso')),
        );

        // Mostrar diálogo de "Redirigiendo..."
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  CircularProgressIndicator(),
                  SizedBox(width: 16),
                  Text("Redirigiendo..."),
                ],
              ),
            ),
          ),
        );

        // Esperar 1 segundo y redirigir a la página de órdenes
        await Future.delayed(const Duration(seconds: 1));
        Navigator.of(context).pop(); // Cerrar el diálogo
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => OrdenCompraListPage()),
        );
      } else {
        // Mostrar snackbar con mensaje de error
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(result['message'])));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Campo de correo electrónico
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(
              labelText: 'Correo electrónico',
              prefixIcon: Icon(Icons.email),
            ),
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingresa tu correo';
              }
              if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                return 'Correo inválido';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          // Campo de contraseña
          TextFormField(
            controller: _passwordController,
            decoration: InputDecoration(
              labelText: 'Contraseña',
              prefixIcon: const Icon(Icons.lock),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassword ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
              ),
            ),
            obscureText: _obscurePassword,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingresa tu contraseña';
              }
              if (value.length < 2) {
                return 'La contraseña debe tener al menos 2 caracteres';
              }
              return null;
            },
          ),
          const SizedBox(height: 24),
          // Botón para iniciar sesión
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _isLoading ? null : _submit,
              child: _isLoading
                  ? const CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    )
                  : const Text('Iniciar sesión'),
            ),
          ),
        ],
      ),
    );
  }
}
