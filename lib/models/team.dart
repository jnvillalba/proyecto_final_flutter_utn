import 'package:proyecto_final_facil/models/player.dart';

class Team {
  final String id;
  final String name;
  final String badge;
  final List<Player> players;
  final int size;

  Team({
    required this.id,
    required this.name,
    required this.badge,
    required this.players,
    this.size = 30,
  });
}
