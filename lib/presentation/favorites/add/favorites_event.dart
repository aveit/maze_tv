part of 'favorites_bloc.dart';

@freezed
class FavoritesEvent with _$FavoritesEvent {
  const FavoritesEvent._();
  const factory FavoritesEvent.add(TVSerie serie) = _Add;
}
