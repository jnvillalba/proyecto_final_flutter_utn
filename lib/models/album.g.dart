// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'album.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Album _$AlbumFromJson(Map<String, dynamic> json) => Album(
      userId: json['userId'] as String,
      stickersIds: (json['stickersIds'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      collectedIds: (json['collectedIds'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$AlbumToJson(Album instance) => <String, dynamic>{
      'userId': instance.userId,
      'stickersIds': instance.stickersIds,
      'collectedIds': instance.collectedIds,
    };
