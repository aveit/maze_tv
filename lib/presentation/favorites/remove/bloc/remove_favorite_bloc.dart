import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:maze_tv/domain/entities/tv_serie.dart';
import 'package:maze_tv/domain/usecases/remove_favorite.dart';

part 'remove_favorite_event.dart';
part 'remove_favorite_state.dart';
part 'remove_favorite_bloc.freezed.dart';

class RemoveFavoriteBloc
    extends Bloc<RemoveFavoriteEvent, RemoveFavoriteState> {
  RemoveFavoriteBloc({
    required this.removeFavorite,
  }) : super(const RemoveFavoriteState.initial()) {
    on<RemoveFavoriteEvent>(_onEvent);
  }

  final RemoveFavorite removeFavorite;

  Future<void> _onEvent(
    RemoveFavoriteEvent event,
    Emitter<RemoveFavoriteState> emit,
  ) async {
    await event.when(
      remove: (serie) async {
        emit(const RemoveFavoriteState.initial());
        await removeFavorite(serie);
        emit(const RemoveFavoriteState.done());
      },
    );
  }
}
