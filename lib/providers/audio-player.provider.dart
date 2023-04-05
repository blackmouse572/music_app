import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_app/models/track.model.dart';

part 'audio-player.provider.freezed.dart';

@freezed
class AudioPlayerState with _$AudioPlayerState {
  const factory AudioPlayerState({
    Track? track,
    required bool isPlaying,
    required Duration position,
    required Duration duration,
    required bool isShuffle,
    required bool isRepeat,
  }) = _AudioPlayerState;
}

class AudioPlayerNotifier extends StateNotifier<AudioPlayerState> {
  AudioPlayerNotifier()
      : super(const AudioPlayerState(
            isPlaying: false,
            position: Duration.zero,
            duration: Duration.zero,
            isShuffle: false,
            isRepeat: false));
  final AudioPlayer _audioPlayer = AudioPlayer();
  late List<Track> _playlist;

  void setPlaylist(List<Track> playlist) {
    _playlist = playlist;
  }

  void init(List<Track> playlist) {
    //Set waveform controller
    _playlist = playlist;
    _audioPlayer.positionStream.listen((position) {
      state = state.copyWith(position: position);
    });
    _audioPlayer.processingStateStream.listen((processingState) {
      if (processingState == ProcessingState.completed) {
        if (state.isRepeat) {
          _audioPlayer.seek(Duration.zero);
          _audioPlayer.play();
        } else if (state.isShuffle) {
          playRandomTrack();
        } else {
          nextTrack();
        }
      } else if (processingState == ProcessingState.ready) {
        _audioPlayer.play();
      } else if (processingState == ProcessingState.loading) {
        state = state.copyWith(isPlaying: false);
      } else if (processingState == ProcessingState.buffering) {
        state = state.copyWith(isPlaying: false);
      }
    });

    _audioPlayer.playbackEventStream.listen((playbackEvent) {
      state = state.copyWith(position: playbackEvent.updatePosition);
    });
  }

  Future<void> play(Track track) async {
    final duration = await _audioPlayer.setUrl(track.trackUrl);
    //final waveform = await _playerController.preparePlayer(path: track.trackUrl);
//    _playerController.startPlayer();
    state = state.copyWith(
        track: track,
        isPlaying: true,
        duration: duration ?? Duration(seconds: track.duration));
  }

  Future<void> pause() async {
    await _audioPlayer.pause();
    state = state.copyWith(isPlaying: false);
  }

  Future<void> resume() async {
    _audioPlayer.play();
    state = state.copyWith(isPlaying: true);
  }

  Future<void> stop() async {
    await _audioPlayer.stop();
    state = state.copyWith(isPlaying: false);
  }

  Future<void> seek(Duration position) async {
    await _audioPlayer.seek(position);
    state = state.copyWith(position: position);
  }

  Future<void> nextTrack() async {
    //If the track is not null, get the index of the track in the playlist
    final playingTrack = state.track;
    if (playingTrack == null) {
      return;
    }
    final currentIndex = _playlist.indexOf(playingTrack);
    //If the index is less than the length of the playlist, play the next track
    if (currentIndex < _playlist.length - 1) {
      await play(_playlist[currentIndex + 1]);
    }

    //If the index is equal to the length of the playlist, play the first track
    if (currentIndex == _playlist.length - 1) {
      await play(_playlist[0]);
    }
  }

  Future<void> previousTrack() async {
    final playingTrack = state.track;
    if (playingTrack == null) {
      return;
    }
    final currentIndex = _playlist.indexOf(playingTrack);
    //If the index is greater than 0, play the previous track
    if (currentIndex > 0) {
      await play(_playlist[currentIndex - 1]);
    }

    //If the index is equal to 0, play the last track
    if (currentIndex == 0) {
      await play(_playlist[_playlist.length - 1]);
    }
  }

  //play random track
  Future<void> playRandomTrack() async {
    final random = Random();
    final randomIndex = random.nextInt(_playlist.length);
    final randomTrack = _playlist[randomIndex];
    await play(randomTrack);
  }

  void toggleShuffle() {
    state = state.copyWith(isShuffle: !state.isShuffle);
  }

  void toggleRepeat() {
    state = state.copyWith(isRepeat: !state.isRepeat);
  }

  Stream<Duration> get positionStream => _audioPlayer.positionStream;

  Stream<Duration?> get durationStream => _audioPlayer.durationStream;
}

final audioPlayerProvider =
    StateNotifierProvider<AudioPlayerNotifier, AudioPlayerState>(
        (ref) => AudioPlayerNotifier());
