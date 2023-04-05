// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'package.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Package _$$_PackageFromJson(Map<String, dynamic> json) => _$_Package(
      id: json['id'] as String?,
      name: json['name'] as String,
      playlists:
          (json['playlists'] as List<dynamic>).map((e) => e as String).toList(),
      price: json['price'] as int,
      playlistModels: (json['playlistModels'] as List<dynamic>?)
          ?.map((e) => Playlist.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_PackageToJson(_$_Package instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'playlists': instance.playlists,
      'price': instance.price,
      'playlistModels': instance.playlistModels,
    };
