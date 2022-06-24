import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:maze_tv/domain/entities/tv_serie.dart';
import 'package:maze_tv/domain/errors/failures.dart';
import 'package:maze_tv/domain/usecases/get_series.dart';

part 'series_bloc.freezed.dart';
part 'series_event.dart';
part 'series_state.dart';

class SeriesBloc extends Bloc<SeriesEvent, SeriesState> {
  SeriesBloc({
    required this.getSeries,
  }) : super(const SeriesState.initial()) {
    on<SeriesEvent>(_onEvent);
  }

  final GetSeries getSeries;

  Future<void> _onEvent(
    SeriesEvent event,
    Emitter<SeriesState> emit,
  ) async {
    await event.when(
      load: () async {
        emit(const SeriesState.loading());

        final seriesOrFailure = await getSeries();
        seriesOrFailure.fold(
          (failure) => emit(SeriesState.failed(failure: failure)),
          (series) => emit(SeriesState.loaded(series: series)),
        );
      },
    );
  }
}
