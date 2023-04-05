// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'packages.provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$PackagesState {
  List<Package> get packages => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isErrored => throw _privateConstructorUsedError;
  String get errorMessage => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PackagesStateCopyWith<PackagesState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PackagesStateCopyWith<$Res> {
  factory $PackagesStateCopyWith(
          PackagesState value, $Res Function(PackagesState) then) =
      _$PackagesStateCopyWithImpl<$Res, PackagesState>;
  @useResult
  $Res call(
      {List<Package> packages,
      bool isLoading,
      bool isErrored,
      String errorMessage});
}

/// @nodoc
class _$PackagesStateCopyWithImpl<$Res, $Val extends PackagesState>
    implements $PackagesStateCopyWith<$Res> {
  _$PackagesStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? packages = null,
    Object? isLoading = null,
    Object? isErrored = null,
    Object? errorMessage = null,
  }) {
    return _then(_value.copyWith(
      packages: null == packages
          ? _value.packages
          : packages // ignore: cast_nullable_to_non_nullable
              as List<Package>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isErrored: null == isErrored
          ? _value.isErrored
          : isErrored // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: null == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PackagesStateCopyWith<$Res>
    implements $PackagesStateCopyWith<$Res> {
  factory _$$_PackagesStateCopyWith(
          _$_PackagesState value, $Res Function(_$_PackagesState) then) =
      __$$_PackagesStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<Package> packages,
      bool isLoading,
      bool isErrored,
      String errorMessage});
}

/// @nodoc
class __$$_PackagesStateCopyWithImpl<$Res>
    extends _$PackagesStateCopyWithImpl<$Res, _$_PackagesState>
    implements _$$_PackagesStateCopyWith<$Res> {
  __$$_PackagesStateCopyWithImpl(
      _$_PackagesState _value, $Res Function(_$_PackagesState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? packages = null,
    Object? isLoading = null,
    Object? isErrored = null,
    Object? errorMessage = null,
  }) {
    return _then(_$_PackagesState(
      packages: null == packages
          ? _value._packages
          : packages // ignore: cast_nullable_to_non_nullable
              as List<Package>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isErrored: null == isErrored
          ? _value.isErrored
          : isErrored // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: null == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_PackagesState implements _PackagesState {
  const _$_PackagesState(
      {required final List<Package> packages,
      required this.isLoading,
      required this.isErrored,
      required this.errorMessage})
      : _packages = packages;

  final List<Package> _packages;
  @override
  List<Package> get packages {
    if (_packages is EqualUnmodifiableListView) return _packages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_packages);
  }

  @override
  final bool isLoading;
  @override
  final bool isErrored;
  @override
  final String errorMessage;

  @override
  String toString() {
    return 'PackagesState(packages: $packages, isLoading: $isLoading, isErrored: $isErrored, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PackagesState &&
            const DeepCollectionEquality().equals(other._packages, _packages) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isErrored, isErrored) ||
                other.isErrored == isErrored) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_packages),
      isLoading,
      isErrored,
      errorMessage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PackagesStateCopyWith<_$_PackagesState> get copyWith =>
      __$$_PackagesStateCopyWithImpl<_$_PackagesState>(this, _$identity);
}

abstract class _PackagesState implements PackagesState {
  const factory _PackagesState(
      {required final List<Package> packages,
      required final bool isLoading,
      required final bool isErrored,
      required final String errorMessage}) = _$_PackagesState;

  @override
  List<Package> get packages;
  @override
  bool get isLoading;
  @override
  bool get isErrored;
  @override
  String get errorMessage;
  @override
  @JsonKey(ignore: true)
  _$$_PackagesStateCopyWith<_$_PackagesState> get copyWith =>
      throw _privateConstructorUsedError;
}
