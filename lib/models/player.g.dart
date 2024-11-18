// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Player _$PlayerFromJson(Map<String, dynamic> json) => Player(
      id: json['id'] as String?,
      name: json['name'] as String,
      position: $enumDecode(_$PlayerPositionEnumMap, json['position']),
      imageUrl: json['imageUrl'] as String,
      number: (json['number'] as num).toInt(),
      isCollected: json['isCollected'] as bool? ?? false,
    );

Map<String, dynamic> _$PlayerToJson(Player instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'position': _$PlayerPositionEnumMap[instance.position]!,
      'imageUrl': instance.imageUrl,
      'number': instance.number,
      'isCollected': instance.isCollected,
    };

const _$PlayerPositionEnumMap = {
  PlayerPosition.goalkeeper: 'goalkeeper',
  PlayerPosition.defender: 'defender',
  PlayerPosition.midfielder: 'midfielder',
  PlayerPosition.forward: 'forward',
};
