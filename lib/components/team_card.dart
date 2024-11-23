import 'package:flutter/material.dart';
import 'package:proyecto_final_facil/models/team.dart';

class TeamCard extends StatelessWidget {
  final Team team;

  const TeamCard({super.key, required this.team});

  void _onTeamTap(BuildContext context, Team team) {
    Navigator.pushNamed(
      context,
      '/team',
      arguments: {
        'teamId': team.id,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: InkWell(
        // de material, genera efecto al tocarlo
        onTap: () => _onTeamTap(context, team),
        child: Container(
          width: 100,
          height: 100,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                team.badge,
                width: 200,
                height: 100,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 16),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  team.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
