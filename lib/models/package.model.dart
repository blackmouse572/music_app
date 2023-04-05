import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:music_app/models/playlist.model.dart';

part 'package.model.freezed.dart';
part 'package.model.g.dart';

@freezed
class Package with _$Package {
  const factory Package({
    String? id,
    required String name,
    required List<String> playlists, //list of playlist ids
    required int price,
    List<Playlist>? playlistModels,
  }) = _Package;

  factory Package.fromJson(Map<String, dynamic> json) =>
      _$PackageFromJson(json);
}
