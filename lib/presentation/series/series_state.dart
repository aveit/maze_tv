part of 'series_bloc.dart';

@freezed
class SeriesState with _$SeriesState {
  const factory SeriesState._({
    required List<TVSerie> series,
    Failure? error,
    bool? isLoading,
  }) = _SeriesState;

  factory SeriesState.initial() => const SeriesState._(
        series: [],
      );
}
