import 'package:flutter/material.dart';
import 'package:proyecto_final_facil/components/custom_textfield.dart';

void main() {
  runApp(LoginPage());
}

class LoginPage extends StatelessWidget {
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ÁlbUTN Login'),
      ),
      body: SafeArea(
          child: Center(
              child: Column(
        children: [
          CustomTextfield(
            hintText: 'Usuario',
            obscureText: false,
            controller: userNameController,
          ),
          CustomTextfield(
            hintText: 'Contraseña',
            obscureText: true,
            controller: passwordController,
          ),
          IconButton(
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(Colors.white),
            ),
            color: Colors.white,
            icon: const Icon(Icons.login),
            onPressed: _onPressed(),
          )
        ],
      ))),
    );
  }

  _onPressed() {
    print('Usuario: ${userNameController.text}');
  }
}
