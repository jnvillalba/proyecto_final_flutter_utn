import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_final_facil/components/custom_btn.dart';
import 'package:proyecto_final_facil/components/custom_textfield.dart';
import 'package:proyecto_final_facil/components/square_btn.dart';
import 'package:proyecto_final_facil/services/auth_service.dart';
import 'package:proyecto_final_facil/services/player_service.dart';

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

    _showLoadingDialog();
    try {
      AuthService().signInWithMail(email, password);
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
    final String message = AuthService().getErrorMessageMail(e);
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

  void _signInGoogle() async {
    _showLoadingDialog();
    try {
      AuthService().signInWithGoogle();
      _navigateToHome();
    } catch (e) {
      _showErrorDialog('Ocurrió un error.');
    } finally {
      _dismissLoadingDialog();
    }
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
              const Padding(
                padding: EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Forgot your login details? ',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                    Text(
                      'Get help logging in.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
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
                  SquareBtn(
                    onTap: () => createTeama(),
                    imagePath: 'lib/icons/google.png',
                    height: 50,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> createTeama() async {
    await createAll();
    print('Team created');
  }
}
