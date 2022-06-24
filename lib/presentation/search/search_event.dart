part of 'search_bloc.dart';

@freezed
class SearchEvent with _$SearchEvent {
  const SearchEvent._();
  const factory SearchEvent.search({required String serieName}) = _Search;
}
