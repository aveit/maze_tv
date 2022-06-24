import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:maze_tv/domain/entities/tv_serie.dart';
import 'package:maze_tv/domain/errors/failures.dart';
import 'package:maze_tv/domain/usecases/search_series_by_name.dart';

part 'search_event.dart';
part 'search_state.dart';
part 'search_bloc.freezed.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc({
    required this.searchSeriesByName,
  }) : super(const SearchState.initial()) {
    on<SearchEvent>(_onEvent);
  }

  final SearchSeriesByName searchSeriesByName;

  Future<void> _onEvent(
    SearchEvent event,
    Emitter<SearchState> emit,
  ) async {
    await event.when(
      search: (serieName) async {
        emit(const SearchState.loading());

        final seriesOrFailure = await searchSeriesByName(serieName: serieName);

        seriesOrFailure.fold(
          (failure) => emit(SearchState.failed(failure: failure)),
          (series) => emit(SearchState.loaded(series: series)),
        );
      },
    );
  }
}
