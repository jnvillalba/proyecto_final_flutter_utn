// Future<int> getCollectedPlayers() async {
//   int collectedCount = 0;
//
//   for (var team in teams) {
//     for (var playerRef in team.playerRefs) {
//       DocumentSnapshot playerSnapshot = await playerRef.get();
//       if (playerSnapshot.exists) {
//         Player player =
//             Player.fromJson(playerSnapshot.data() as Map<String, dynamic>);
//         // Si el jugador está coleccionado, aumentamos el contador
//         if (player.isCollected) {
//           collectedCount++;
//         }
//       }
//     }
//   }
//   return collectedCount;
// }
//
// Future<double> getCollectionProgress(totalPlayers) async {
//   int collected = await getCollectedPlayers();
//   if (totalPlayers > 0) {
//     return (collected / totalPlayers) * 100;
//   } else {
//     return 0;
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proyecto_final_facil/models/player.dart';

Future<void> createAll() async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  DocumentReference teamRef = await firestore.collection('teams').add({
    'name': 'FC Barcelona',
    'badge': 'https://example.com/barcelona-badge.png',
    'size': 25,
    'playerRefs': [],
  });

  print('Equipo creado con ID: ${teamRef.id}');

  Player player1 = Player(
    id: null,
    name: 'Lionel Messi',
    position: 'Forward',
    imageUrl: 'https://example.com/messi.png',
    number: 10,
    teamRef: teamRef,
    isCollected: true,
  );

  Player player2 = Player(
    id: null,
    name: 'Gerard Piqué',
    position: 'Defender',
    imageUrl: 'https://example.com/pique.png',
    number: 3,
    teamRef: teamRef,
    isCollected: false,
  );

  DocumentReference player1Ref =
      await firestore.collection('players').add(player1.toJson());
  DocumentReference player2Ref =
      await firestore.collection('players').add(player2.toJson());

  print('Jugador 1 creado con ID: ${player1Ref.id}');
  print('Jugador 2 creado con ID: ${player2Ref.id}');

  await teamRef.update({
    'playerRefs': FieldValue.arrayUnion([player1Ref, player2Ref]),
  });

  print('Referencias de jugadores añadidas al equipo');
}
