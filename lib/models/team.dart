import 'package:json_annotation/json_annotation.dart';
import 'package:proyecto_final_facil/models/player.dart';

part 'team.g.dart';

@JsonSerializable()
class Team {
  String? id;
  final String name;
  final String badge;
  List<Player>? players;
  final List<String?> playerIds;
  final int size = 30;

  Team({
    this.id,
    required this.name,
    required this.badge,
    required this.players,
    this.playerIds = const [],
  });

  factory Team.fromJson(Map<String, dynamic> json) => _$TeamFromJson(json);

  Map<String, dynamic> toJson() => _$TeamToJson(this);
}
