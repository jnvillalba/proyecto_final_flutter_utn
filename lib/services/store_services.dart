import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proyecto_final_facil/models/player.dart';
import 'package:proyecto_final_facil/models/team.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<List> getPlayers() async {
  List players = [];
  CollectionReference playersRef = db.collection('players');
  QuerySnapshot querySnapshot = await playersRef.get();

  for (var doc in querySnapshot.docs) {
    final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    final player = Player(
      id: doc.id,
      number: data['number'],
      name: data['name'],
      position: data['position'],
      imageUrl: '',
    );

    players.add(player);
  }
  return players;
}

Future<List> getTeams() async {
  List teams = [];
  CollectionReference teamsRef = db.collection('teams');
  QuerySnapshot querySnapshot = await teamsRef.get();

  for (var doc in querySnapshot.docs) {
    final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    final team = Team(
        id: doc.id,
        name: data['name'],
        badge: data['badge'],
        players: [],
        size: data['size']);

    teams.add(team);
  }
  return teams;
}
