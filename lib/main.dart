import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_final_facil/firebase_options.dart';
import 'package:proyecto_final_facil/pages/album_page.dart';
import 'package:proyecto_final_facil/pages/auth_page.dart';
import 'package:proyecto_final_facil/pages/menu_page.dart';
import 'package:proyecto_final_facil/pages/open_package_page.dart';
import 'package:proyecto_final_facil/pages/opened_stickers_page.dart';
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
        '/open': (context) => const OpenPackagePage(),
        '/openedStickers': (context) => const OpenedStickersPage(),
      },
      onGenerateRoute: (settings) {
        return MaterialPageRoute(builder: (context) => const AuthPage());
      },
    );
  }
}

//TODO: - ideas
//revisar login google
