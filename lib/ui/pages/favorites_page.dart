import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maze_tv/constants.dart';
import 'package:maze_tv/presentation/favorites/get/get_favorites_bloc.dart';
import 'package:maze_tv/presentation/favorites/remove/bloc/remove_favorite_bloc.dart';
import 'package:maze_tv/ui/components/app_loader.dart';
import 'package:maze_tv/ui/components/generic_error.dart';
import 'package:maze_tv/ui/components/informative_text.dart';
import 'package:maze_tv/ui/components/serie_poster.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<RemoveFavoriteBloc, RemoveFavoriteState>(
        listener: (context, state) {
          state.when(
            initial: () {},
            done: () {
              context.read<GetFavoritesBloc>().add(
                    const GetFavoritesEvent.get(),
                  );
            },
          );
        },
        child: BlocConsumer<GetFavoritesBloc, GetFavoritesState>(
          listener: (context, state) {
            state.maybeWhen(
              orElse: () {},
              error: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Could not get favorites')),
                );
              },
            );
          },
          builder: (context, state) {
            return state.maybeWhen(
              orElse: () {
                return const AppLoader();
              },
              error: () {
                return const GenericError();
              },
              loaded: (favs) {
                if (favs.isEmpty) {
                  return const InformativeText(text: 'No favorites added.');
                }
                return SingleChildScrollView(
                  child: Column(
                    children: favs.map(
                      (serie) {
                        return Padding(
                          padding: const EdgeInsets.all(kSmallPadding),
                          child: Column(
                            children: [
                              SeriePoster(serie: serie),
                              IconButton(
                                onPressed: () {
                                  context.read<RemoveFavoriteBloc>().add(
                                        RemoveFavoriteEvent.remove(serie),
                                      );
                                },
                                icon: Icon(
                                  Icons.favorite_rounded,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ).toList(),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
