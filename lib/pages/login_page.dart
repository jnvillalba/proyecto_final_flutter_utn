import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_final_facil/components/custom_btn.dart';
import 'package:proyecto_final_facil/components/custom_textfield.dart';

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

    _showLoadingDialog();
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      _navigateToHome();
    } on FirebaseAuthException catch (e) {
      _handleAuthException(e);
    } catch (e) {
      _showErrorDialog('Ocurrió un error.');
    } finally {
      _dismissLoadingDialog();
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
    final Map<String, String> errorMessages = {
      'invalid-email': 'El formato del correo electrónico es inválido.',
      'user-not-found': 'No se encontró una cuenta con este correo.',
      'wrong-password': 'La contraseña es incorrecta.',
      'too-many-requests':
          'Demasiados intentos fallidos. Intenta nuevamente más tarde.',
    };

    final String message = errorMessages[e.code] ?? 'Error desconocido.';
    _showErrorDialog(message);
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
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

  void _navigateToHome() {
    if (mounted) {
      Navigator.of(context).pushReplacementNamed('/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ÁlbUTN Login'),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTextfield(
                hintText: 'User',
                obscureText: false,
                controller: userNameController,
              ),
              CustomTextfield(
                hintText: 'Password',
                obscureText: true,
                controller: passwordController,
              ),
              CustomBtn(text: 'Login', onTap: _signIn),
            ],
          ),
        ),
      ),
    );
  }
}
