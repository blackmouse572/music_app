// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'point_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$PointState {
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isAuth => throw _privateConstructorUsedError;
  User? get user => throw _privateConstructorUsedError;
  int get point => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PointStateCopyWith<PointState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PointStateCopyWith<$Res> {
  factory $PointStateCopyWith(
          PointState value, $Res Function(PointState) then) =
      _$PointStateCopyWithImpl<$Res, PointState>;
  @useResult
  $Res call({bool isLoading, bool isAuth, User? user, int point});
}

/// @nodoc
class _$PointStateCopyWithImpl<$Res, $Val extends PointState>
    implements $PointStateCopyWith<$Res> {
  _$PointStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? isAuth = null,
    Object? user = freezed,
    Object? point = null,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isAuth: null == isAuth
          ? _value.isAuth
          : isAuth // ignore: cast_nullable_to_non_nullable
              as bool,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User?,
      point: null == point
          ? _value.point
          : point // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PointStateCopyWith<$Res>
    implements $PointStateCopyWith<$Res> {
  factory _$$_PointStateCopyWith(
          _$_PointState value, $Res Function(_$_PointState) then) =
      __$$_PointStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isLoading, bool isAuth, User? user, int point});
}

/// @nodoc
class __$$_PointStateCopyWithImpl<$Res>
    extends _$PointStateCopyWithImpl<$Res, _$_PointState>
    implements _$$_PointStateCopyWith<$Res> {
  __$$_PointStateCopyWithImpl(
      _$_PointState _value, $Res Function(_$_PointState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? isAuth = null,
    Object? user = freezed,
    Object? point = null,
  }) {
    return _then(_$_PointState(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isAuth: null == isAuth
          ? _value.isAuth
          : isAuth // ignore: cast_nullable_to_non_nullable
              as bool,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User?,
      point: null == point
          ? _value.point
          : point // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_PointState implements _PointState {
  const _$_PointState(
      {required this.isLoading,
      required this.isAuth,
      required this.user,
      required this.point});

  @override
  final bool isLoading;
  @override
  final bool isAuth;
  @override
  final User? user;
  @override
  final int point;

  @override
  String toString() {
    return 'PointState(isLoading: $isLoading, isAuth: $isAuth, user: $user, point: $point)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PointState &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isAuth, isAuth) || other.isAuth == isAuth) &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.point, point) || other.point == point));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isLoading, isAuth, user, point);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PointStateCopyWith<_$_PointState> get copyWith =>
      __$$_PointStateCopyWithImpl<_$_PointState>(this, _$identity);
}

abstract class _PointState implements PointState {
  const factory _PointState(
      {required final bool isLoading,
      required final bool isAuth,
      required final User? user,
      required final int point}) = _$_PointState;

  @override
  bool get isLoading;
  @override
  bool get isAuth;
  @override
  User? get user;
  @override
  int get point;
  @override
  @JsonKey(ignore: true)
  _$$_PointStateCopyWith<_$_PointState> get copyWith =>
      throw _privateConstructorUsedError;
}
