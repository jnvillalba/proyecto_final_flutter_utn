import 'package:proyecto_final_facil/models/team.dart';

class Album {
  final List<Team> teams;

  Album({required this.teams});

  int get totalPlayers =>
      teams.fold(0, (sum, team) => sum + team.playerRefs.length);
}
