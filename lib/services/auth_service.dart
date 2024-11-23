import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../models/album.dart';

class AuthService {
  Future<void> signInWithGoogle() async {
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

    if (gUser == null) return;

    final GoogleSignInAuthentication gAuth = await gUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );

    final userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    await _createAlbumIfNotExists(userCredential.user);
  }

  Future<void> signInWithMail(String email, String password) async {
    final userCredential =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    await _createAlbumIfNotExists(userCredential.user);
  }

  Future<void> _createAlbumIfNotExists(User? user) async {
    if (user == null) return;

    final userId = user.uid;
    final albumDoc =
        FirebaseFirestore.instance.collection('albums').doc(userId);

    final albumSnapshot = await albumDoc.get();

    if (!albumSnapshot.exists) {
      final album = Album(userId: userId);
      await albumDoc.set(album.toJson());
    }
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
