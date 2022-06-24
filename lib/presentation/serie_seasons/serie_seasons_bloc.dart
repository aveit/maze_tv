import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:maze_tv/domain/entities/serie_season.dart';
import 'package:maze_tv/domain/entities/tv_serie.dart';
import 'package:maze_tv/domain/errors/failures.dart';
import 'package:maze_tv/domain/usecases/get_serie_seasons.dart';

part 'serie_seasons_bloc.freezed.dart';
part 'serie_seasons_event.dart';
part 'serie_seasons_state.dart';

class SerieSeasonsBloc extends Bloc<SerieSeasonsEvent, SerieSeasonsState> {
  SerieSeasonsBloc({
    required this.getSeriesSeasons,
  }) : super(const SerieSeasonsState.initial()) {
    on<SerieSeasonsEvent>(_onEvent);
  }

  final GetSerieSeasons getSeriesSeasons;

  Future<void> _onEvent(
    SerieSeasonsEvent event,
    Emitter<SerieSeasonsState> emit,
  ) async {
    await event.when(
      load: (serie) async {
        emit(const SerieSeasonsState.loading());

        final seasonsOrFailure = await getSeriesSeasons(serie: serie);

        seasonsOrFailure.fold(
          (failure) => emit(SerieSeasonsState.failed(failure: failure)),
          (seasons) => emit(SerieSeasonsState.loaded(seasons: seasons)),
        );
      },
    );
  }
}
