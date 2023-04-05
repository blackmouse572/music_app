// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'track.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Track _$$_TrackFromJson(Map<String, dynamic> json) => _$_Track(
      artist: json['artist'] as String,
      title: json['title'] as String,
      coverUrl: json['coverUrl'] as String,
      duration: json['duration'] as int,
      trackUrl: json['trackUrl'] as String,
      videoUrl: json['videoUrl'] as String,
    );

Map<String, dynamic> _$$_TrackToJson(_$_Track instance) => <String, dynamic>{
      'artist': instance.artist,
      'title': instance.title,
      'coverUrl': instance.coverUrl,
      'duration': instance.duration,
      'trackUrl': instance.trackUrl,
      'videoUrl': instance.videoUrl,
    };
