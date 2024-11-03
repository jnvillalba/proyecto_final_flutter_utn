import 'package:proyecto_final_facil/models/team.dart';

class Album {
  final List<Team> teams;

  Album({required this.teams});

  // Método para contar el progreso de la colección
  int get totalPlayers =>
      teams.fold(0, (sum, team) => sum + team.players.length);

  int get collectedPlayers => teams.fold(
        0,
        (sum, team) =>
            sum + team.players.where((player) => player.isCollected).length,
      );

  double get collectionProgress =>
      totalPlayers > 0 ? (collectedPlayers / totalPlayers) * 100 : 0;
}
