import 'package:flutter/material.dart';
import 'package:proyecto_final_facil/pages/auth_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ÁlbUTN',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.blue[900],
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.indigo,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: AuthPage(),
    );
  }
}

//TODO: ideas
// persistencia
// - abrir sobres - aca puedo aplicar animacion y una pagina solo para eso
// - cambio de pagina dentro de un equipo
// - ver perfil de jugador
