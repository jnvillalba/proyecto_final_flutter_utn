import 'package:flutter/material.dart';

class MenuPage extends StatelessWidget {
  final List<Map<String, dynamic>> menuOptions = [
    {'label': 'Álbum', 'onTap': () => print('Ir al Álbum')},
    {'label': 'Abrir Sobre', 'onTap': () => print('Abrir Sobre')},
    {'label': 'Logout', 'onTap': () => print('Logout')},
  ];

  MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
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
