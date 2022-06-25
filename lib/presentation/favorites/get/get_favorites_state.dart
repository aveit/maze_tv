part of 'get_favorites_bloc.dart';

@freezed
class GetFavoritesState with _$GetFavoritesState {
  const GetFavoritesState._();
  const factory GetFavoritesState.initial() = _Initial;
  const factory GetFavoritesState.loading() = _Loading;
  const factory GetFavoritesState.error() = _Error;
  const factory GetFavoritesState.loaded({
    required List<TVSerie> series,
  }) = _Loaded;
}
