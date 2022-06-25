import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:maze_tv/domain/entities/tv_serie.dart';
import 'package:maze_tv/domain/usecases/save_serie_on_favorites.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';
part 'favorites_bloc.freezed.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  FavoritesBloc({
    required this.saveSerieOnFavorites,
  }) : super(const FavoritesState.initial()) {
    on<FavoritesEvent>(_onEvent);
  }

  final SaveSerieOnFavorites saveSerieOnFavorites;

  Future<void> _onEvent(
    FavoritesEvent event,
    Emitter<FavoritesState> emit,
  ) async {
    await event.when(
      add: (serie) async {
        emit(const FavoritesState.initial());
        final savedOrFailure = await saveSerieOnFavorites(serie);
        savedOrFailure.fold(
          (_) => emit(const FavoritesState.error()),
          (_) => emit(const FavoritesState.ok()),
        );
      },
    );
  }
}
