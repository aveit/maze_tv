part of 'series_bloc.dart';

@freezed
class SeriesEvent with _$SeriesEvent {
  const SeriesEvent._();
  const factory SeriesEvent.loadNextPage() = _LoadNextPage;
}
