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
  }) : super(SeriesState.initial()) {
    on<SeriesEvent>(_onEvent);
  }

  final GetSeries getSeries;
  int currentPage = 1;

  Future<void> _onEvent(
    SeriesEvent event,
    Emitter<SeriesState> emit,
  ) async {
    await event.when(
      loadNextPage: () async {
        if (state.isLoading == true) return;

        emit(state.copyWith(isLoading: true));

        final seriesOrFailure = await getSeries(page: currentPage++);
        await seriesOrFailure.fold(
          (failure) {
            currentPage--;
            emit(
              state.copyWith(
                error: failure,
                isLoading: false,
              ),
            );
          },
          (series) async {
            emit(
              state.copyWith(
                series: [...state.series + series],
                error: null,
              ),
            );
            await Future<dynamic>.delayed(const Duration(seconds: 1));
            emit(state.copyWith(isLoading: false));
          },
        );
      },
    );
  }
}
