import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proyecto_final_facil/models/album.dart';
import 'package:proyecto_final_facil/models/player.dart';
import 'package:proyecto_final_facil/services/auth_service.dart';
import 'package:proyecto_final_facil/services/store_services.dart';

final FirebaseFirestore db = FirebaseFirestore.instance;

Future<Album?> getAlbum(String userId) async {
  try {
    DocumentSnapshot doc = await db.collection('albums').doc(userId).get();

    if (doc.exists) {
      return Album.fromJson(doc.data() as Map<String, dynamic>);
    } else {
      // TODO mejorar esto
      return null;
    }
  } catch (e) {
    print('Error al obtener el álbum: $e');
    return null;
  }
}

Future<List<Player>> getPlayersFromAlbum(
    String userId, List<String> ids) async {
  try {
    List<Player> players = await Future.wait(
      ids.map((id) async => await getPlayer(id)).toList(),
    );
    print('players: $players');
    return players;
  } catch (e) {
    print('Error al obtener los jugadores: $e');
    return [];
  }
}

Future<List<Player>> getPlayersFromStickers() async {
  try {
    var userId = getCurrentUserId();
    Album? album = await getAlbum(userId!);
    if (album != null) {
      return getPlayersFromAlbum(userId, album.stickersIds);
    } else {
      print('album null: $userId');
      return [];
    }
  } catch (e) {
    print('Error al obtener los jugadores: $e');
    return [];
  }
}

Future<List<Player?>> getCollectedPlayersFromAlbum() async {
  try {
    var userId = getCurrentUserId();
    Album? album = await getAlbum(userId!);
    if (album != null) {
      List<Player?> players =
          await getPlayersFromAlbum(userId, album.collectedIds);
      _markPlayersAsCollected(players);
      return players;
    } else {
      return [];
    }
  } catch (e) {
    print('Error al obtener los jugadores: $e');
    return [];
  }
}

void _markPlayersAsCollected(List<Player?> players) {
  for (final player in players) {
    player?.setCollected();
  }
}

Future<void> collectSticker(String userId, String playerId) async {
  try {
    final albumRef = db.collection('albums');

    final querySnapshot =
        await albumRef.where('userId', isEqualTo: userId).get();

    if (querySnapshot.docs.isEmpty) {
      throw Exception('No se encontró un álbum para el usuario $userId');
    }
    final doc = querySnapshot.docs.first;

    final data = doc.data();
    final stickersIds = List<String>.from(data['stickersIds'] ?? []);
    final collectedIds = List<String>.from(data['collectedIds'] ?? []);

    if (stickersIds.contains(playerId) && !collectedIds.contains(playerId)) {
      stickersIds.remove(playerId);
      collectedIds.add(playerId);

      await albumRef.doc(doc.id).update({
        'stickersIds': stickersIds,
        'collectedIds': collectedIds,
      });
      print('El jugador $playerId agregado al album del usuario $userId');
    }
  } catch (e) {
    print('Error al actualizar el álbum: $e');
    rethrow;
  }
}

Future<void> addStickerToAlbum(String playerId) async {
  try {
    final userId = getCurrentUserId();
    final albumRef = db.collection('albums');

    final querySnapshot =
        await albumRef.where('userId', isEqualTo: userId).get();

    if (querySnapshot.docs.isEmpty) {
      throw Exception('No se encontró un álbum para el usuario $userId');
    }
    final doc = querySnapshot.docs.first;

    final data = doc.data();
    final stickersIds = List<String>.from(data['stickersIds'] ?? []);

    if (!stickersIds.contains(playerId)) {
      stickersIds.add(playerId);

      await albumRef.doc(doc.id).update({
        'stickersIds': stickersIds,
      });
      print('El jugador $playerId agregado al álbum del usuario $userId');
    } else {
      print('El jugador $playerId ya está en la lista de stickers.');
    }
  } catch (e) {
    print('Error al actualizar el álbum: $e');
    rethrow;
  }
}

Future<void> removeStickerFromAlbum(String playerId) async {
  try {
    final userId = getCurrentUserId();
    final albumRef = db.collection('albums');

    final querySnapshot =
        await albumRef.where('userId', isEqualTo: userId).get();

    if (querySnapshot.docs.isEmpty) {
      throw Exception('No se encontró un álbum para el usuario $userId');
    }
    final doc = querySnapshot.docs.first;

    final data = doc.data();
    final stickersIds = List<String>.from(data['stickersIds'] ?? []);

    if (stickersIds.contains(playerId)) {
      stickersIds.remove(playerId);

      await albumRef.doc(doc.id).update({
        'stickersIds': stickersIds,
      });

      print(
          'El jugador $playerId ha sido eliminado del álbum del usuario $userId');
    } else {
      print('El jugador $playerId no está en la lista de stickers.');
    }
  } catch (e) {
    print('Error al eliminar el jugador del álbum: $e');
    rethrow;
  }
}

Future<void> deleteTeam(String teamId) async {
  try {
    final teamRef = db.collection('teams').doc(teamId);

    // Verificar si el documento existe
    final docSnapshot = await teamRef.get();
    if (!docSnapshot.exists) {
      throw Exception('El equipo con ID $teamId no existe.');
    }

    // Eliminar el documento
    await teamRef.delete();
    print('El equipo con ID $teamId ha sido eliminado.');
  } catch (e) {
    print('Error al eliminar el equipo: $e');
    rethrow;
  }
}
