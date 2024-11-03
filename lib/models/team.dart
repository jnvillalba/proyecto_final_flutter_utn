import 'package:proyecto_final_facil/models/player.dart';
import 'package:proyecto_final_facil/models/stadium.dart';

class Team {
  final String id;
  final String name;
  final String badge;
  final List<Player> players;
  final Stadium stadium;

  Team({
    required this.id,
    required this.name,
    required this.badge,
    required this.players,
    required this.stadium,
  });
}
