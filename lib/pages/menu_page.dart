import 'package:flutter/material.dart';
import 'package:proyecto_final_facil/services/auth_service.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    void navigate(BuildContext context, String route) {
      final userId = getCurrentUserId();
      if (userId == null) {
        AuthService().logout(context);
        return;
      } else {
        Navigator.pushNamed(
          context,
          route,
          arguments: {
            'userid': userId,
          },
        );
      }
    }

    final List<Map<String, dynamic>> menuOptions = [
      {'label': 'Álbum', 'onTap': () => navigate(context, '/home')},
      {'label': 'Abrir Sobre', 'onTap': () => navigate(context, '/open')},
      {'label': 'Logout', 'onTap': () => AuthService().logout(context)},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Menú'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: menuOptions
                  .map((option) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: ElevatedButton(
                          onPressed: option['onTap'] as VoidCallback,
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(double.infinity, 48),
                          ),
                          child: Text(option['label']),
                        ),
                      ))
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }
}
