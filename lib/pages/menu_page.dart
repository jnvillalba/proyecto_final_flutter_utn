import 'package:flutter/material.dart';
import 'package:proyecto_final_facil/data.dart';
import 'package:proyecto_final_facil/models/team.dart';
import 'package:proyecto_final_facil/services/auth_service.dart';
import 'package:proyecto_final_facil/services/player_service.dart';
import 'package:proyecto_final_facil/services/team_service.dart';

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

    Future<void> createplayers() async {
      try {
        var player = spreen();
        await savePlayer(player);
        print(player.name);
      } catch (e) {
        print('Error: $e');
      }
    }

    Future<void> createTeam() async {
      try {
        Team team = riestra();
        saveTeam(team);
        var name = team.name;
        print('Created: $name');
      } catch (e) {
        print('Error: $e');
      }
    }

    final List<Map<String, dynamic>> menuOptions = [
      {'label': 'Álbum', 'onTap': () => navigate(context, '/home')},
      {'label': 'Abrir Sobre', 'onTap': () => navigate(context, '/open')},
      {'label': 'Logout', 'onTap': () => AuthService().logout(context)},
      //{'label': 'Create Team', 'onTap': () => createTeam()},
      // {'label': 'Create Player', 'onTap': () => createplayers()},
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
              children: [
                Image.asset(
                  'lib/icons/LPF.png',
                  height: 200,
                ),
                const SizedBox(height: 50),
                ...menuOptions.map((option) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: ElevatedButton(
                        onPressed: option['onTap'] as VoidCallback,
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 48),
                        ),
                        child: Text(option['label']),
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
