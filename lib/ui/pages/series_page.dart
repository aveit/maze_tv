import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maze_tv/app/view/app.dart';
import 'package:maze_tv/presentation/bloc/series_bloc.dart';
import 'package:maze_tv/ui/components/rating.dart';
import 'package:maze_tv/ui/pages/series_details_page.dart';

class SeriesPage extends StatefulWidget {
  const SeriesPage({super.key});

  @override
  State<SeriesPage> createState() => _SeriesPageState();
}

class _SeriesPageState extends State<SeriesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Series'),
        centerTitle: true,
      ),
      body: BlocBuilder<SeriesBloc, SeriesState>(
        builder: (context, state) {
          return state.when(
            initial: () {
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
            loading: () {
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
            loaded: (series) {
              return GridView.count(
                crossAxisCount: 1,
                children: series.map((current) {
                  final rating = current.rating.average;
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        SeriesDetailsPage.routeName,
                        arguments: current,
                      );
                    },
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(16),
                          ),
                          child: Hero(
                            tag: ValueKey(current),
                            child: Image.network(current.image.medium),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Text(current.name),
                        ),
                        RatingBar(
                          valueKey: current.id.toString(),
                          rating: rating,
                          size: 25,
                        ),
                      ],
                    ),
                  );
                }).toList(),
              );
            },
            failed: (failure) {
              return Text('FAIOOOO');
            },
          );
        },
      ),
    );
  }
}
