import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:maze_tv/constants.dart';
import 'package:maze_tv/presentation/series/series_bloc.dart';
import 'package:maze_tv/ui/components/app_loader.dart';
import 'package:maze_tv/ui/components/generic_error.dart';
import 'package:maze_tv/ui/components/serie_poster.dart';

class SeriesPage extends StatefulWidget {
  const SeriesPage({super.key});

  @override
  State<SeriesPage> createState() => _SeriesPageState();
}

class _SeriesPageState extends State<SeriesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SeriesBloc, SeriesState>(
        builder: (context, state) {
          return state.maybeWhen(
            orElse: () => const AppLoader(),
            loaded: (series) {
              return MasonryGridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: kSmallPadding,
                crossAxisSpacing: kBigSpace,
                itemBuilder: (context, index) {
                  final currentSerie = series.elementAt(index);
                  return SeriePoster(
                    serie: currentSerie,
                    shouldCheckRating: true,
                  );
                },
                itemCount: series.length,
              );
            },
            failed: (failure) {
              return const Center(child: GenericError());
            },
          );
        },
      ),
    );
  }
}
