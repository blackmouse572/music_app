// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pick-playlist.provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$PickPlaylistState {
  Playlist? get playlist => throw _privateConstructorUsedError;
  Package? get package => throw _privateConstructorUsedError;
  Track? get playingTrack => throw _privateConstructorUsedError;
  bool get isPlaying => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PickPlaylistStateCopyWith<PickPlaylistState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PickPlaylistStateCopyWith<$Res> {
  factory $PickPlaylistStateCopyWith(
          PickPlaylistState value, $Res Function(PickPlaylistState) then) =
      _$PickPlaylistStateCopyWithImpl<$Res, PickPlaylistState>;
  @useResult
  $Res call(
      {Playlist? playlist,
      Package? package,
      Track? playingTrack,
      bool isPlaying});

  $PlaylistCopyWith<$Res>? get playlist;
  $PackageCopyWith<$Res>? get package;
  $TrackCopyWith<$Res>? get playingTrack;
}

/// @nodoc
class _$PickPlaylistStateCopyWithImpl<$Res, $Val extends PickPlaylistState>
    implements $PickPlaylistStateCopyWith<$Res> {
  _$PickPlaylistStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? playlist = freezed,
    Object? package = freezed,
    Object? playingTrack = freezed,
    Object? isPlaying = null,
  }) {
    return _then(_value.copyWith(
      playlist: freezed == playlist
          ? _value.playlist
          : playlist // ignore: cast_nullable_to_non_nullable
              as Playlist?,
      package: freezed == package
          ? _value.package
          : package // ignore: cast_nullable_to_non_nullable
              as Package?,
      playingTrack: freezed == playingTrack
          ? _value.playingTrack
          : playingTrack // ignore: cast_nullable_to_non_nullable
              as Track?,
      isPlaying: null == isPlaying
          ? _value.isPlaying
          : isPlaying // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $PlaylistCopyWith<$Res>? get playlist {
    if (_value.playlist == null) {
      return null;
    }

    return $PlaylistCopyWith<$Res>(_value.playlist!, (value) {
      return _then(_value.copyWith(playlist: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $PackageCopyWith<$Res>? get package {
    if (_value.package == null) {
      return null;
    }

    return $PackageCopyWith<$Res>(_value.package!, (value) {
      return _then(_value.copyWith(package: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $TrackCopyWith<$Res>? get playingTrack {
    if (_value.playingTrack == null) {
      return null;
    }

    return $TrackCopyWith<$Res>(_value.playingTrack!, (value) {
      return _then(_value.copyWith(playingTrack: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_PickPlaylistStateCopyWith<$Res>
    implements $PickPlaylistStateCopyWith<$Res> {
  factory _$$_PickPlaylistStateCopyWith(_$_PickPlaylistState value,
          $Res Function(_$_PickPlaylistState) then) =
      __$$_PickPlaylistStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Playlist? playlist,
      Package? package,
      Track? playingTrack,
      bool isPlaying});

  @override
  $PlaylistCopyWith<$Res>? get playlist;
  @override
  $PackageCopyWith<$Res>? get package;
  @override
  $TrackCopyWith<$Res>? get playingTrack;
}

/// @nodoc
class __$$_PickPlaylistStateCopyWithImpl<$Res>
    extends _$PickPlaylistStateCopyWithImpl<$Res, _$_PickPlaylistState>
    implements _$$_PickPlaylistStateCopyWith<$Res> {
  __$$_PickPlaylistStateCopyWithImpl(
      _$_PickPlaylistState _value, $Res Function(_$_PickPlaylistState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? playlist = freezed,
    Object? package = freezed,
    Object? playingTrack = freezed,
    Object? isPlaying = null,
  }) {
    return _then(_$_PickPlaylistState(
      playlist: freezed == playlist
          ? _value.playlist
          : playlist // ignore: cast_nullable_to_non_nullable
              as Playlist?,
      package: freezed == package
          ? _value.package
          : package // ignore: cast_nullable_to_non_nullable
              as Package?,
      playingTrack: freezed == playingTrack
          ? _value.playingTrack
          : playingTrack // ignore: cast_nullable_to_non_nullable
              as Track?,
      isPlaying: null == isPlaying
          ? _value.isPlaying
          : isPlaying // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_PickPlaylistState implements _PickPlaylistState {
  const _$_PickPlaylistState(
      {required this.playlist,
      required this.package,
      required this.playingTrack,
      required this.isPlaying});

  @override
  final Playlist? playlist;
  @override
  final Package? package;
  @override
  final Track? playingTrack;
  @override
  final bool isPlaying;

  @override
  String toString() {
    return 'PickPlaylistState(playlist: $playlist, package: $package, playingTrack: $playingTrack, isPlaying: $isPlaying)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PickPlaylistState &&
            (identical(other.playlist, playlist) ||
                other.playlist == playlist) &&
            (identical(other.package, package) || other.package == package) &&
            (identical(other.playingTrack, playingTrack) ||
                other.playingTrack == playingTrack) &&
            (identical(other.isPlaying, isPlaying) ||
                other.isPlaying == isPlaying));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, playlist, package, playingTrack, isPlaying);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PickPlaylistStateCopyWith<_$_PickPlaylistState> get copyWith =>
      __$$_PickPlaylistStateCopyWithImpl<_$_PickPlaylistState>(
          this, _$identity);
}

abstract class _PickPlaylistState implements PickPlaylistState {
  const factory _PickPlaylistState(
      {required final Playlist? playlist,
      required final Package? package,
      required final Track? playingTrack,
      required final bool isPlaying}) = _$_PickPlaylistState;

  @override
  Playlist? get playlist;
  @override
  Package? get package;
  @override
  Track? get playingTrack;
  @override
  bool get isPlaying;
  @override
  @JsonKey(ignore: true)
  _$$_PickPlaylistStateCopyWith<_$_PickPlaylistState> get copyWith =>
      throw _privateConstructorUsedError;
}
