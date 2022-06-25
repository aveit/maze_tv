part of 'favorites_bloc.dart';

@freezed
class FavoritesState with _$FavoritesState {
  const FavoritesState._();
  const factory FavoritesState.initial() = _Initial;
  const factory FavoritesState.error() = _Error;
  const factory FavoritesState.ok() = _Ok;
}
