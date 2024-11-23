import 'package:flutter/material.dart';
import 'package:proyecto_final_facil/components/team_card.dart';
import 'package:proyecto_final_facil/models/team.dart';
import 'package:proyecto_final_facil/services/store_services.dart';

class AlbumPage extends StatefulWidget {
  const AlbumPage({super.key});

  @override
  State<AlbumPage> createState() => _AlbumPageState();
}

class _AlbumPageState extends State<AlbumPage> {
  late List<Team> teams = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ÁlbUTN'),
      ),
      body: FutureBuilder(
          future: getAllTeamsWithPlayers(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            }
            teams = snapshot.data as List<Team>;
            return _buildAllTeams(context);
          }),
    );
  }

  Widget _buildAllTeams(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: teams.length,
      itemBuilder: (context, index) {
        final team = teams[index];
        return TeamCard(team: team);
      },
    );
  }
}
