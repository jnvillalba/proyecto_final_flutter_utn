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
