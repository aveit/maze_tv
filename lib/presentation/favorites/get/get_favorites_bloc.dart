import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:maze_tv/domain/entities/tv_serie.dart';
import 'package:maze_tv/domain/usecases/get_favorites.dart';

part 'get_favorites_event.dart';
part 'get_favorites_state.dart';
part 'get_favorites_bloc.freezed.dart';

class GetFavoritesBloc extends Bloc<GetFavoritesEvent, GetFavoritesState> {
  GetFavoritesBloc({
    required this.getFavorites,
  }) : super(const GetFavoritesState.initial()) {
    on<GetFavoritesEvent>(_onEvent);
  }

  final GetFavorites getFavorites;

  Future<void> _onEvent(
    GetFavoritesEvent event,
    Emitter<GetFavoritesState> emit,
  ) async {
    await event.when(
      get: () async {
        emit(const GetFavoritesState.loading());
        //Simulates the loading state
        await Future<dynamic>.delayed(const Duration(milliseconds: 200));

        final favsOrFailure = await getFavorites();
        favsOrFailure.fold(
          (_) => emit(const GetFavoritesState.error()),
          (favs) => emit(GetFavoritesState.loaded(series: favs)),
        );
      },
    );
  }
}
