// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'series_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$SeriesEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadNextPage,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? loadNextPage,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadNextPage,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadNextPage value) loadNextPage,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_LoadNextPage value)? loadNextPage,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadNextPage value)? loadNextPage,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SeriesEventCopyWith<$Res> {
  factory $SeriesEventCopyWith(
          SeriesEvent value, $Res Function(SeriesEvent) then) =
      _$SeriesEventCopyWithImpl<$Res>;
}

/// @nodoc
class _$SeriesEventCopyWithImpl<$Res> implements $SeriesEventCopyWith<$Res> {
  _$SeriesEventCopyWithImpl(this._value, this._then);

  final SeriesEvent _value;
  // ignore: unused_field
  final $Res Function(SeriesEvent) _then;
}

/// @nodoc
abstract class _$$_LoadNextPageCopyWith<$Res> {
  factory _$$_LoadNextPageCopyWith(
          _$_LoadNextPage value, $Res Function(_$_LoadNextPage) then) =
      __$$_LoadNextPageCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_LoadNextPageCopyWithImpl<$Res>
    extends _$SeriesEventCopyWithImpl<$Res>
    implements _$$_LoadNextPageCopyWith<$Res> {
  __$$_LoadNextPageCopyWithImpl(
      _$_LoadNextPage _value, $Res Function(_$_LoadNextPage) _then)
      : super(_value, (v) => _then(v as _$_LoadNextPage));

  @override
  _$_LoadNextPage get _value => super._value as _$_LoadNextPage;
}

/// @nodoc

class _$_LoadNextPage extends _LoadNextPage {
  const _$_LoadNextPage() : super._();

  @override
  String toString() {
    return 'SeriesEvent.loadNextPage()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_LoadNextPage);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadNextPage,
  }) {
    return loadNextPage();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? loadNextPage,
  }) {
    return loadNextPage?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadNextPage,
    required TResult orElse(),
  }) {
    if (loadNextPage != null) {
      return loadNextPage();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadNextPage value) loadNextPage,
  }) {
    return loadNextPage(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_LoadNextPage value)? loadNextPage,
  }) {
    return loadNextPage?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadNextPage value)? loadNextPage,
    required TResult orElse(),
  }) {
    if (loadNextPage != null) {
      return loadNextPage(this);
    }
    return orElse();
  }
}

abstract class _LoadNextPage extends SeriesEvent {
  const factory _LoadNextPage() = _$_LoadNextPage;
  const _LoadNextPage._() : super._();
}

/// @nodoc
mixin _$SeriesState {
  List<TVSerie> get series =>
      throw _privateConstructorUsedError; // ignore: unused_element
  Failure? get error =>
      throw _privateConstructorUsedError; // ignore: unused_element
  bool? get isLoading => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SeriesStateCopyWith<SeriesState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SeriesStateCopyWith<$Res> {
  factory $SeriesStateCopyWith(
          SeriesState value, $Res Function(SeriesState) then) =
      _$SeriesStateCopyWithImpl<$Res>;
  $Res call({List<TVSerie> series, Failure? error, bool? isLoading});
}

/// @nodoc
class _$SeriesStateCopyWithImpl<$Res> implements $SeriesStateCopyWith<$Res> {
  _$SeriesStateCopyWithImpl(this._value, this._then);

  final SeriesState _value;
  // ignore: unused_field
  final $Res Function(SeriesState) _then;

  @override
  $Res call({
    Object? series = freezed,
    Object? error = freezed,
    Object? isLoading = freezed,
  }) {
    return _then(_value.copyWith(
      series: series == freezed
          ? _value.series
          : series // ignore: cast_nullable_to_non_nullable
              as List<TVSerie>,
      error: error == freezed
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as Failure?,
      isLoading: isLoading == freezed
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
abstract class _$$_SeriesStateCopyWith<$Res>
    implements $SeriesStateCopyWith<$Res> {
  factory _$$_SeriesStateCopyWith(
          _$_SeriesState value, $Res Function(_$_SeriesState) then) =
      __$$_SeriesStateCopyWithImpl<$Res>;
  @override
  $Res call({List<TVSerie> series, Failure? error, bool? isLoading});
}

/// @nodoc
class __$$_SeriesStateCopyWithImpl<$Res> extends _$SeriesStateCopyWithImpl<$Res>
    implements _$$_SeriesStateCopyWith<$Res> {
  __$$_SeriesStateCopyWithImpl(
      _$_SeriesState _value, $Res Function(_$_SeriesState) _then)
      : super(_value, (v) => _then(v as _$_SeriesState));

  @override
  _$_SeriesState get _value => super._value as _$_SeriesState;

  @override
  $Res call({
    Object? series = freezed,
    Object? error = freezed,
    Object? isLoading = freezed,
  }) {
    return _then(_$_SeriesState(
      series: series == freezed
          ? _value._series
          : series // ignore: cast_nullable_to_non_nullable
              as List<TVSerie>,
      error: error == freezed
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as Failure?,
      isLoading: isLoading == freezed
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc

class _$_SeriesState implements _SeriesState {
  const _$_SeriesState(
      {required final List<TVSerie> series, this.error, this.isLoading})
      : _series = series;

  final List<TVSerie> _series;
  @override
  List<TVSerie> get series {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_series);
  }

// ignore: unused_element
  @override
  final Failure? error;
// ignore: unused_element
  @override
  final bool? isLoading;

  @override
  String toString() {
    return 'SeriesState._(series: $series, error: $error, isLoading: $isLoading)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SeriesState &&
            const DeepCollectionEquality().equals(other._series, _series) &&
            const DeepCollectionEquality().equals(other.error, error) &&
            const DeepCollectionEquality().equals(other.isLoading, isLoading));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_series),
      const DeepCollectionEquality().hash(error),
      const DeepCollectionEquality().hash(isLoading));

  @JsonKey(ignore: true)
  @override
  _$$_SeriesStateCopyWith<_$_SeriesState> get copyWith =>
      __$$_SeriesStateCopyWithImpl<_$_SeriesState>(this, _$identity);
}

abstract class _SeriesState implements SeriesState {
  const factory _SeriesState(
      {required final List<TVSerie> series,
      final Failure? error,
      final bool? isLoading}) = _$_SeriesState;

  @override
  List<TVSerie> get series => throw _privateConstructorUsedError;
  @override // ignore: unused_element
  Failure? get error => throw _privateConstructorUsedError;
  @override // ignore: unused_element
  bool? get isLoading => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_SeriesStateCopyWith<_$_SeriesState> get copyWith =>
      throw _privateConstructorUsedError;
}
