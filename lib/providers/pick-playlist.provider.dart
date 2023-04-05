import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:music_app/models/package.model.dart';
import 'package:music_app/models/playlist.model.dart';
import 'package:music_app/models/track.model.dart';

part 'pick-playlist.provider.freezed.dart';

@freezed
class PickPlaylistState with _$PickPlaylistState {
  const factory PickPlaylistState({
    required Playlist? playlist,
    required Package? package,
    required Track? playingTrack,
    required bool isPlaying,
  }) = _PickPlaylistState;
}

//stream music provider
class PickPlaylistProvider extends StateNotifier<PickPlaylistState> {
  PickPlaylistProvider()
      : super(const PickPlaylistState(
            package: null,
            playlist: null,
            playingTrack: null,
            isPlaying: false));

  void setPackage(Package package) {
    state = state.copyWith(package: package);
  }

  void setPlaylist(Playlist playlist) {
    state = state.copyWith(playlist: playlist);
  }

  void setPlayingTrack(Track track) {
    state = state.copyWith(playingTrack: track);
  }

  void nextTrack() {
    final playlist = state.playlist;
    if (playlist != null) {
      final tracks = playlist.tracks;
      final playingTrack = state.playingTrack;
      if (playingTrack != null) {
        final index = tracks.indexOf(playingTrack);
        if (index < tracks.length - 1) {
          state = state.copyWith(playingTrack: tracks[index + 1]);
        }
      }
    }
  }

  void previousTrack() {
    final playlist = state.playlist;
    if (playlist != null) {
      final tracks = playlist.tracks;
      final playingTrack = state.playingTrack;
      if (playingTrack != null) {
        final index = tracks.indexOf(playingTrack);
        if (index > 0) {
          state = state.copyWith(playingTrack: tracks[index - 1]);
        }
      }
    }
  }

  void play() {
    state = state.copyWith(isPlaying: true);
  }

  void pause() {
    state = state.copyWith(isPlaying: false);
  }

  void togglePlay() {
    state = state.copyWith(isPlaying: !state.isPlaying);
  }

  void reset() {
    state = const PickPlaylistState(
        package: null, playlist: null, playingTrack: null, isPlaying: false);
  }
}

final pickPlaylistProvider =
    StateNotifierProvider<PickPlaylistProvider, PickPlaylistState>(
  (ref) => PickPlaylistProvider(),
);
