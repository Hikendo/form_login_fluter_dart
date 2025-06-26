import 'package:flutter/material.dart';
import 'package:mi_app/const/constants_app.dart';
import 'package:mi_app/views/login/forms/form_login.dart';
import 'package:mi_app/widgets/imagen_app.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ImagenApp(imagePath: dimankaLogo),
              const SizedBox(height: 32),
              // Formulario de login
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: FormLogin(key: const Key('form_login')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
