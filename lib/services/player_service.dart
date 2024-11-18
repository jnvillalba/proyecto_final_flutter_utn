import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proyecto_final_facil/models/player.dart';
import 'package:proyecto_final_facil/services/store_services.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<List<Player>> openPack() async {
  try {
    final snapshot = await db.collection('players').get();

    List<Player> players = snapshot.docs.map((doc) {
      var player = Player.fromJson(doc.data());
      player.id = doc.id;
      return player;
    }).toList();

    players.shuffle(Random());
    return players.take(5).toList();
  } catch (e) {
    throw Exception('Error opening pack: $e');
  }
}

Future<List<Player>> getPlayersByTeamId(String teamId) async {
  try {
    if (teamId.isEmpty) {
      throw Exception('Team ID is required');
    }
    final team = await getTeam(teamId);

    final playerIds = team.playerIds;

    final players = await Future.wait(
      playerIds.map((playerId) async => await getPlayer(playerId!)).toList(),
    );

    return players;
  } catch (e) {
    throw Exception('Error fetching players for team: $e');
  }
}
