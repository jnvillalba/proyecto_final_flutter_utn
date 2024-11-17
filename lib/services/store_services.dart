import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proyecto_final_facil/models/player.dart';
import 'package:proyecto_final_facil/models/team.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<void> createTeam(Team team) async {
  try {
    CollectionReference teamsRef = db.collection('teams');
    await teamsRef.add(team.toJson());
  } catch (e) {
    print(e);
  }
}

Future<DocumentReference> createPlayer(Player player) async {
  try {
    CollectionReference playersRef = db.collection('players');

    DocumentReference playerRef = await playersRef.add({
      'name': player.name,
      'position': player.position.toString(),
      'imageUrl': player.imageUrl,
      'number': player.number,
      'isCollected': player.isCollected,
      'teamRef': player.teamRef,
    });

    return playerRef;
  } catch (e) {
    print('Error al crear el jugador: $e');
    rethrow;
  }
}

Future<void> createTeamWithPlayers(Team team, List<Player> players) async {
  try {
    List<DocumentReference> playerRefs = [];
    for (var player in players) {
      DocumentReference playerRef = await createPlayer(player);
      playerRefs.add(playerRef);
    }
    CollectionReference teamsRef = db.collection('teams');

    await teamsRef.add({
      'name': team.name,
      'badge': team.badge,
      'playerRefs': playerRefs,
      'size': team.size,
    });

    print('Equipo creado con éxito, jugadores referenciados');
  } catch (e) {
    print('Error al crear el equipo: $e');
    rethrow;
  }
}

Future<List<Player>> getPlayersFromTeam(Team team) async {
  try {
    List<Player> players = [];
    for (var playerRef in team.playerRefs) {
      DocumentSnapshot playerSnapshot = await playerRef.get();
      if (playerSnapshot.exists) {
        players.add(
            Player.fromJson(playerSnapshot.data() as Map<String, dynamic>));
      }
    }
    return players;
  } catch (e) {
    print('Error al obtener jugadores del equipo: $e');
    rethrow;
  }
}

Future<List<Team>> getAllTeams() async {
  try {
    CollectionReference teamsRef = db.collection('teams');
    QuerySnapshot snapshot = await teamsRef.get();

    List<Team> teams = snapshot.docs.map((doc) {
      return Team.fromJson(doc.data() as Map<String, dynamic>)
          .copyWithId(doc.id);
    }).toList();

    return teams;
  } catch (e) {
    print('Error al obtener los equipos: $e');
    rethrow;
  }
}
