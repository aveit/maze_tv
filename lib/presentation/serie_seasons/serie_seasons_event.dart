part of 'serie_seasons_bloc.dart';

@freezed
class SerieSeasonsEvent with _$SerieSeasonsEvent {
  const SerieSeasonsEvent._();
  const factory SerieSeasonsEvent.load({required TVSerie serie}) = _Load;
}
