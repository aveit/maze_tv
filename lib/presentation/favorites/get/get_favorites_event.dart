part of 'get_favorites_bloc.dart';

@freezed
class GetFavoritesEvent with _$GetFavoritesEvent {
  const GetFavoritesEvent._();
  const factory GetFavoritesEvent.get() = _Get;
}
