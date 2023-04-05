import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:music_app/models/track.model.dart';

part 'playlist.model.freezed.dart';
part 'playlist.model.g.dart';

@freezed
class Playlist with _$Playlist {
  const factory Playlist({
    String? id,
    required String name,
    required String thumbnailUrl,
    required List<Track> tracks,
  }) = _Playlist;

  factory Playlist.fromJson(Map<String, dynamic> json) =>
      _$PlaylistFromJson(json);
}

String getArtists(List<Track> tracks, {int maxCharacters = 10}) {
  final artists = tracks.map((e) => e.artist).toSet().toList();
  //Max 10 characters
  if (artists.join(', ').length > maxCharacters) {
    return artists.join(', ').substring(0, 10) + '...';
  }
  return artists.join(', ');
}

//Overload getArtisst from only one track
String getArtistsFromTrack(Track track, {int maxCharacters = 10}) {
  final artists = track.artist;
  //Max 10 characters
  if (artists.length > maxCharacters) {
    return artists.substring(0, 10) + '...';
  }
  return artists;
}
