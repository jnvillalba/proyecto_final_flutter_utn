// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Team _$TeamFromJson(Map<String, dynamic> json) => Team(
      id: json['id'] as String?,
      name: json['name'] as String,
      badge: json['badge'] as String,
      players: (json['players'] as List<dynamic>?)
          ?.map((e) => Player.fromJson(e as Map<String, dynamic>))
          .toList(),
      playerIds: (json['playerIds'] as List<dynamic>?)
              ?.map((e) => e as String?)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$TeamToJson(Team instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'badge': instance.badge,
      'players': instance.players,
      'playerIds': instance.playerIds,
    };
