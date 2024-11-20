import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proyecto_final_facil/models/player.dart';

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
