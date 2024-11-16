import 'package:proyecto_final_facil/models/enums/player_position.dart';

class Player {
  final String id;
  final String name;
  final PlayerPosition position;
  final String imageUrl;
  final int number;
  bool isCollected; // Estado de la figurita (si la tengo o no)

  Player({
    required this.id,
    required this.name,
    required this.position,
    required this.imageUrl,
    required this.number,
    this.isCollected = false,
  });

  Player.gk({
    required this.id,
    required this.name,
    required this.imageUrl,
    this.isCollected = false,
    required this.number,
    this.position = PlayerPosition.goalkeeper,
  });
}
