part of 'serie_seasons_bloc.dart';

@freezed
class SerieSeasonsState with _$SerieSeasonsState {
  const SerieSeasonsState._();
  const factory SerieSeasonsState.initial() = _Initial;
  const factory SerieSeasonsState.loading() = _Loading;
  const factory SerieSeasonsState.loaded({
    required List<SerieSeason> seasons,
  }) = _Loaded;
  const factory SerieSeasonsState.failed({required Failure failure}) = _Failed;
}
