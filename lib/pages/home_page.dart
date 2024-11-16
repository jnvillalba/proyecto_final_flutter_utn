import 'package:flutter/material.dart';
import 'package:proyecto_final_facil/models/team.dart';
import 'package:proyecto_final_facil/pages/team_detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required List teams});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final List<Team> teams;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ÁlbUTN'),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: teams.length,
        itemBuilder: (context, index) {
          final team = teams[index];
          return _buildTeamCard(context, team);
        },
      ),
    );
  }

  //privado solo lo usa el home
  Widget _buildTeamCard(BuildContext context, Team team) {
    //TODO pasar a widget
    return Card(
      elevation: 4, // sombra
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

  void _onTeamTap(BuildContext context, Team team) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TeamDetailPage(team: team),
      ),
    );
  }
}
