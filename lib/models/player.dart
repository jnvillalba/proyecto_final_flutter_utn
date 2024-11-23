import 'package:json_annotation/json_annotation.dart';
import 'package:proyecto_final_facil/models/enums/player_position.dart';

part 'player.g.dart';

@JsonSerializable()
class Player {
  String? id;
  final String name;
  final PlayerPosition position;
  final String imageUrl;
  final int number;
  bool isCollected;

  Player({
    this.id,
    required this.name,
    required this.position,
    required this.imageUrl,
    required this.number,
    this.isCollected = false,
  });

  Player.gk({
    this.id,
    required this.name,
    required this.imageUrl,
    required this.number,
    this.isCollected = false,
    this.position = PlayerPosition.goalkeeper,
  });

  factory Player.fromJson(Map<String, dynamic> json) => _$PlayerFromJson(json);

  Map<String, dynamic> toJson() => _$PlayerToJson(this);

  void setCollected() {
    isCollected = true;
  }
}
