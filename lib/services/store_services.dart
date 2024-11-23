import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proyecto_final_facil/models/player.dart';
import 'package:proyecto_final_facil/models/team.dart';
import 'package:proyecto_final_facil/services/auth_service.dart';

import '../models/album.dart';
import 'album_service.dart';

FirebaseFirestore db = FirebaseFirestore.instance;
//TODO implementar excepciones y manejo de errores
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

Future<Team> getTeamWithPlayersCollected(String teamId) async {
  try {
    if (teamId.isEmpty) {
      throw Exception('Team ID is required');
    }
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
    final teamQuery = await db.collection('teams').orderBy('name').get();

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
