import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proyecto_final_facil/models/player.dart';

FirebaseFirestore db = FirebaseFirestore.instance;
var playersCollection = db.collection('players');

Future<void> savePlayer(Player player) async {
  await playersCollection.doc(player.id).set(player.toJson());
}

Future<Player> getPlayer(String playerId) async {
  final doc = await playersCollection.doc(playerId).get();
  final player = Player.fromJson(doc.data()!);
  player.id = doc.id;
  return player;
}

Future<List<Player>> openPack() async {
  try {
    final snapshot = await playersCollection.get();

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
