import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proyecto_final_facil/models/player.dart';
import 'package:proyecto_final_facil/models/team.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<void> savePlayer(Player player) async {
  await db.collection('players').doc(player.id).set(player.toJson());
}

Future<void> saveTeam(Team team) async {
  await db.collection('teams').doc(team.id).set(team.toJson());
}

Future<Player> getPlayer(String playerId) async {
  final doc = await db.collection('players').doc(playerId).get();
  final player = Player.fromJson(doc.data()!);
  player.id = doc.id;
  return player;
}

Future<Team> getTeam(String teamId) async {
  if (teamId.isEmpty) {
    throw Exception('Team ID is required');
  }
  final doc = await db.collection('teams').doc(teamId).get();
  final team = Team.fromJson(doc.data()!);
  team.id = doc.id;
  return team;
}

Future<Team> _populateTeamWithPlayers(Team team) async {
  final players = await Future.wait(
    team.playerIds.map((playerId) async => await getPlayer(playerId!)),
  );
  team.players = players;
  return team;
}

Future<Team> getTeamWithPlayers(String teamId) async {
  try {
    if (teamId.isEmpty) {
      throw Exception('Team ID is required');
    }
    final team = await getTeam(teamId);
    return await _populateTeamWithPlayers(team);
  } catch (e) {
    throw Exception('Error al obtener equipo y jugadores de id $teamId: $e');
  }
}

Future<List<Team>> getAllTeamsWithPlayers() async {
  try {
    final teamQuery = await db.collection('teams').get();

    return await Future.wait(
      teamQuery.docs.map((teamDoc) async {
        final team = Team.fromJson(teamDoc.data());
        team.id = teamDoc.id;
        return await _populateTeamWithPlayers(team);
      }).toList(),
    );
  } catch (e) {
    throw Exception('Error al obtener equipos y jugadores: $e');
  }
}
