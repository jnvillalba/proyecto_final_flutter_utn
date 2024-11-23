import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_final_facil/firebase_options.dart';
import 'package:proyecto_final_facil/pages/album_page.dart';
import 'package:proyecto_final_facil/pages/auth_page.dart';
import 'package:proyecto_final_facil/pages/menu_page.dart';
import 'package:proyecto_final_facil/pages/team_detail_page.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
        ),
      ),
      routes: {
        '/': (context) => const AuthPage(),
        '/team': (context) => const TeamDetailPage(),
        '/menu': (context) => const MenuPage(),
        '/home': (context) => const AlbumPage(),
      },
      onGenerateRoute: (settings) {
        return MaterialPageRoute(builder: (context) => const AuthPage());
      },
    );
  }
}

//TODO: ideas
// servicios
// - abrir sobres - aca puedo aplicar animacion y una pagina solo para eso
// - cambio de pagina dentro de un equipo
// - ver perfil de jugador
// badge con secciones
// sign out (FirebaseAuth.instance.signOut())
// descartar repetidas (delete crud)
// Update para actualizar pegadas
