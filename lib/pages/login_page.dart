//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_final_facil/components/custom_btn.dart';
import 'package:proyecto_final_facil/components/custom_textfield.dart';

void main() {
  runApp(LoginPage());
}

class LoginPage extends StatelessWidget {
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();

  LoginPage({super.key});

  void _signIn() async {
    print('User: ${userNameController.text}');
    print('Password: ${passwordController.text}');
    // BuildContext dialogContext = context;
    // showDialog(
    //     context: context,
    //     barrierDismissible: false,
    //     builder: (BuildContext context) {
    //       return AlertDialog(
    //         title: const Text('Logging in...'),
    //         content: const LinearProgressIndicator(),
    //       );
    //     });
    // try {
    //   await FirebaseAuth.instance.signInWithEmailAndPassword(
    //     email: userNameController.text,
    //     password: passwordController.text,
    //   );
    //   ifMounted(dialogContext, mounted)
    //
    // } on FirebaseAuthException catch (e) {
    //   ifMounted(dialogContext, mounted)
    //   print('Error initializing Firebase: $e');
    //   Navigator.of(dialogContext).pop();
    // } catch (e) {
    //   ifMounted(dialogContext, mounted)
    //   print('Error catch (: $e');
    //   Navigator.of(dialogContext).pop();
    // }
  }

  // void ifMounted((dialogContext, mounted) {
  // if (mounted) {
  // Navigator.of(dialogContext).pop();
  // Navigator.of(context).pushReplacementNamed('/home');
  // } else {
  // print('Error initializing Firebase: not mounted', mounted);
  // }
  // });

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
