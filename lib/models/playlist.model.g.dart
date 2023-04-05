// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playlist.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Playlist _$$_PlaylistFromJson(Map<String, dynamic> json) => _$_Playlist(
      id: json['id'] as String?,
      name: json['name'] as String,
      thumbnailUrl: json['thumbnailUrl'] as String,
      tracks: (json['tracks'] as List<dynamic>)
          .map((e) => Track.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_PlaylistToJson(_$_Playlist instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'thumbnailUrl': instance.thumbnailUrl,
      'tracks': instance.tracks,
    };
