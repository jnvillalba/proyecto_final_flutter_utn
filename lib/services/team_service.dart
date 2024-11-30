import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proyecto_final_facil/models/album.dart';
import 'package:proyecto_final_facil/models/team.dart';
import 'package:proyecto_final_facil/services/album_service.dart';
import 'package:proyecto_final_facil/services/auth_service.dart';
import 'package:proyecto_final_facil/services/player_service.dart';

FirebaseFirestore db = FirebaseFirestore.instance;
var teamsCollection = db.collection('teams');

Future<void> saveTeam(Team team) async {
  await teamsCollection.doc(team.id).set(team.toJson());
}

Future<void> deleteTeam(String teamId) async {
  try {
    final teamRef = teamsCollection.doc(teamId);

    final docSnapshot = await teamRef.get();
    if (!docSnapshot.exists) {
      throw Exception('El equipo con ID $teamId no existe.');
    }

    await teamRef.delete();
  } catch (e) {
    print('Error al eliminar el equipo: $e');
    rethrow;
  }
}

Future<Team> getTeam(String teamId) async {
  validateTeamId(teamId);
  final doc = await teamsCollection.doc(teamId).get();
  final team = Team.fromJson(doc.data()!);
  team.id = doc.id;
  return team;
}

Future<Team> _populateTeamWithPlayers(Team team) async {
  try {
    if (team.playerIds.isEmpty) {
      return team;
    }
    final players = await Future.wait(
      team.playerIds.map((playerId) async => await getPlayer(playerId!)),
    );
    team.players = players;
    return team;
  } catch (e) {
    throw Exception('Error al obtener jugadores de equipo: ${team.name} $e');
  }
}

void validateTeamId(String teamId) {
  if (teamId.isEmpty) {
    throw Exception('Team ID is required');
  }
}

Future<Team> getTeamWithPlayers(String teamId) async {
  try {
    validateTeamId(teamId);
    final team = await getTeam(teamId);
    return await _populateTeamWithPlayers(team);
  } catch (e) {
    throw Exception('Error al obtener equipo y jugadores de id $teamId: $e');
  }
}

Future<Team> getTeamWithPlayersCollected(String teamId) async {
  try {
    validateTeamId(teamId);
    final team = await getTeam(teamId);
    await _populateTeamWithPlayers(team);
    return await _updateTeamPlayersCollected(team);
  } catch (e) {
    throw Exception('Error al obtener equipo y jugadores de id $teamId: $e');
  }
}

Future<Team> _updateTeamPlayersCollected(Team team) async {
  var userId = getCurrentUserId();
  Album? album = await getAlbum(userId!);
  if (album == null) {
    return team;
  }
  for (var player in team.players!) {
    if (album.collectedIds.contains(player.id) && !player.isCollected) {
      player.setCollected();
    }
  }
  return team;
}

Future<List<Team>> getAllTeamsWithPlayers() async {
  try {
    final teamQuery = await teamsCollection.orderBy('name').get();
    return await Future.wait(
      teamQuery.docs.map((teamDoc) async {
        final team = Team.fromJson(teamDoc.data());
        team.id = teamDoc.id;
        return await _populateTeamWithPlayers(team);
      }).toList(),
    );
  } catch (e) {
    throw Exception('Error getAllTeamsWithPlayers: $e');
  }
}
