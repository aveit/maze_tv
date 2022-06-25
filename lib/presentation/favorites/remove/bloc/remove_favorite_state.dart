part of 'remove_favorite_bloc.dart';

@freezed
class RemoveFavoriteState with _$RemoveFavoriteState {
  const RemoveFavoriteState._();
  const factory RemoveFavoriteState.initial() = _Initial;
  const factory RemoveFavoriteState.done() = _Done;
}
