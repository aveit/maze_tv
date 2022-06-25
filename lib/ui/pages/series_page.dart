import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:maze_tv/constants.dart';
import 'package:maze_tv/presentation/series/series_bloc.dart';
import 'package:maze_tv/ui/components/app_loader.dart';
import 'package:maze_tv/ui/components/informative_text.dart';
import 'package:maze_tv/ui/components/serie_poster.dart';

class SeriesPage extends StatefulWidget {
  const SeriesPage({super.key});

  @override
  State<SeriesPage> createState() => _SeriesPageState();
}

class _SeriesPageState extends State<SeriesPage> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()
      ..addListener(
        () {
          if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent * .6) {
            context.read<SeriesBloc>().add(const SeriesEvent.loadNextPage());
          }
        },
      );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<SeriesBloc, SeriesState>(
        listenWhen: (previous, current) {
          if (current.isLoading == true) return false;
          return true;
        },
        listener: (context, state) {
          if (state.error != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('An error ocurred'),
                duration: Duration(seconds: 1),
              ),
            );
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              if (state.series.isNotEmpty)
                Flexible(
                  child: MasonryGridView.count(
                    crossAxisCount: 2,
                    controller: _scrollController,
                    mainAxisSpacing: kSmallPadding,
                    crossAxisSpacing: kBigSpace,
                    itemBuilder: (context, index) {
                      final currentSerie = state.series.elementAt(index);
                      return SeriePoster(
                        serie: currentSerie,
                        shouldCheckRating: true,
                      );
                    },
                    itemCount: state.series.length,
                  ),
                ),
              if (state.series.isEmpty && state.isLoading == false)
                Column(
                  children: [
                    const SizedBox(height: kBigSpace),
                    const Center(
                      child: InformativeText(text: 'No Series found'),
                    ),
                    const SizedBox(height: kBigSpace),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                      ),
                      onPressed: () {
                        context
                            .read<SeriesBloc>()
                            .add(const SeriesEvent.loadNextPage());
                      },
                      child: Text(
                        'Try again',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              if (state.isLoading == true)
                const Padding(
                  padding: EdgeInsets.all(kSmallPadding),
                  child: AppLoader(),
                ),
            ],
          );
        },
      ),
    );
  }
}
