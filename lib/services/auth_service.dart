import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  signInWithGoogle() async {
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication gAuth = await gUser!.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  void signInWithMail(email, password) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  String getErrorMessageMail(FirebaseAuthException e) {
    final Map<String, String> errorMessages = {
      'invalid-email': 'El formato del correo electrónico es inválido.',
      'user-not-found': 'No se encontró una cuenta con este correo.',
      'wrong-password': 'La contraseña es incorrecta.',
      'too-many-requests':
          'Demasiados intentos fallidos. Intenta nuevamente más tarde.',
    };

    final String message = errorMessages[e.code] ?? 'Error desconocido.';
    return message;
  }

  void logout(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushReplacementNamed(context, '/');
    } catch (e) {
      print("Error durante el logout: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error al cerrar sesión')),
      );
    }
  }
}
