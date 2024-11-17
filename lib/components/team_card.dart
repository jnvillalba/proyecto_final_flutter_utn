import 'package:flutter/material.dart';
import 'package:proyecto_final_facil/models/team.dart';
import 'package:proyecto_final_facil/pages/team_detail_page.dart';

class TeamCard extends StatelessWidget {
  final Team team;

  const TeamCard({super.key, required this.team});

  //TODO cambiar router 2.41
  void _onTeamTap(BuildContext context, Team team) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TeamDetailPage(team: team),
      ),
    );
  }

  void _onTeamTap2(BuildContext context, snapshot) async {
    await Navigator.pushNamed(
      context,
      '/team/',
      arguments: snapshot.data?['uid'],
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
              Text(
                team.name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
