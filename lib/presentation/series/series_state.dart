part of 'series_bloc.dart';

@freezed
class SeriesState with _$SeriesState {
  const SeriesState._();
  const factory SeriesState.initial() = _Initial;
  const factory SeriesState.loading() = _Loading;
  const factory SeriesState.loaded({required List<TVSerie> series}) = _Loaded;
  const factory SeriesState.failed({required Failure failure}) = _Failed;
}
