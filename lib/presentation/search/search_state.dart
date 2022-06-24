part of 'search_bloc.dart';

@freezed
class SearchState with _$SearchState {
  const SearchState._();
  const factory SearchState.initial() = _Initial;
  const factory SearchState.loading() = _Loading;
  const factory SearchState.loaded({required List<TVSerie> series}) = _Loaded;
  const factory SearchState.failed({required Failure failure}) = _Failed;
}
