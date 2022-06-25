part of 'remove_favorite_bloc.dart';

@freezed
class RemoveFavoriteEvent with _$RemoveFavoriteEvent {
  const RemoveFavoriteEvent._();
  const factory RemoveFavoriteEvent.remove(TVSerie serie) = _Remove;
}
