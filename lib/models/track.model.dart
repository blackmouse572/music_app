import 'package:freezed_annotation/freezed_annotation.dart';

part 'track.model.freezed.dart';
part 'track.model.g.dart';

@freezed
class Track with _$Track {
  const factory Track({
    required String artist,
    required String title,
    required String coverUrl,
    required int duration,
    required String trackUrl,
    required String videoUrl,
  }) = _Track;

  factory Track.fromJson(Map<String, dynamic> json) => _$TrackFromJson(json);
}
