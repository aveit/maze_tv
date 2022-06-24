import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
              return GridView.count(
                crossAxisCount: 1,
                children: series.map((current) {
                  return SeriePoster(serie: current);
                }).toList(),
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
