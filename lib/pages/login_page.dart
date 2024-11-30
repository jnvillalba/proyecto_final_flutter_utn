import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_final_facil/components/buttons/custom_btn.dart';
import 'package:proyecto_final_facil/components/buttons/square_btn.dart';
import 'package:proyecto_final_facil/components/login/custom_textfield.dart';
import 'package:proyecto_final_facil/services/auth_service.dart';

import '../components/login/text_divider.dart';

void main() {
  runApp(const LoginPage());
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();

  void _signIn() async {
    final String email = userNameController.text;
    final String password = passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      _showErrorDialog('Por favor, complete los campos.');
      return;
    }

    _showLoadingDialog();

    try {
      await AuthService().signInWithMail(email, password);
      _navigateToHome();
    } on FirebaseAuthException catch (e) {
      _dismissLoadingDialog();
      _handleAuthException(e);
    } catch (e) {
      _dismissLoadingDialog();
      _showErrorDialog('Ocurrió un error inesperado.');
    }
  }

  void _showLoadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const AlertDialog(
        title: Text('Logging in...'),
        content: LinearProgressIndicator(),
      ),
    );
  }

  void _dismissLoadingDialog() {
    if (mounted) {
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  void _handleAuthException(FirebaseAuthException e) {
    String message;
    try {
      message = AuthService().getErrorMessageMail(e);
    } catch (e) {
      message = 'Ocurrió un error.';
    }
    _showErrorDialog(message);
  }

  void _showErrorDialog(String message) {
    if (mounted) {
      showDialog(
        //context
        context: Navigator.of(context).overlay!.context,
        builder: (_) => AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  void _signInGoogle() async {
    _showLoadingDialog();

    try {
      await AuthService().signInWithGoogle();

      _navigateToHome();
    } catch (e) {
      _dismissLoadingDialog();
      _showErrorDialog('Ocurrió un error.');
    }
  }

  void _navigateToHome() {
    if (mounted) {
      _dismissLoadingDialog();
      Navigator.of(context).pushReplacementNamed('/menu');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ÁlbUTN Login'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxHeight: 200),
                    child: Image.asset(
                      'lib/icons/LPF.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Campo de Usuario
                CustomTextfield(
                  hintText: 'User',
                  obscureText: false,
                  controller: userNameController,
                ),
                const SizedBox(height: 10),

                CustomTextfield(
                  hintText: 'Password',
                  obscureText: true,
                  controller: passwordController,
                ),
                const SizedBox(height: 20),

                CustomBtn(
                  text: 'Login',
                  onTap: _signIn,
                ),
                const SizedBox(height: 20),

                const TextDivider(
                  text: 'OR',
                  dividerColor: Colors.white,
                  textColor: Colors.white,
                  thickness: 1.0,
                ),
                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: SquareBtn(
                        onTap: _signInGoogle,
                        imagePath: 'lib/icons/google.png',
                        height: 50,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
