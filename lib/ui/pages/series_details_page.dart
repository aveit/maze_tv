import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maze_tv/constants.dart';
import 'package:maze_tv/domain/entities/tv_serie.dart';
import 'package:maze_tv/presentation/favorites/add/favorites_bloc.dart';
import 'package:maze_tv/presentation/favorites/get/get_favorites_bloc.dart';
import 'package:maze_tv/presentation/serie_seasons/serie_seasons_bloc.dart';
import 'package:maze_tv/ui/components/app_loader.dart';
import 'package:maze_tv/ui/components/generic_error.dart';
import 'package:maze_tv/ui/components/informative_text.dart';
import 'package:maze_tv/ui/components/season_item.dart';
import 'package:maze_tv/ui/components/serie_genre.dart';
import 'package:maze_tv/ui/components/serie_poster.dart';
import 'package:maze_tv/ui/components/serie_schedule.dart';
import 'package:maze_tv/ui/components/serie_summary.dart';

class SeriesDetailsPage extends StatefulWidget {
  const SeriesDetailsPage({super.key, required this.serie});
  static const routeName = 'SeriesDetailsPage';

  final TVSerie serie;

  @override
  State<SeriesDetailsPage> createState() => _SeriesDetailsPageState();
}

class _SeriesDetailsPageState extends State<SeriesDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<FavoritesBloc, FavoritesState>(
      listener: (context, state) {
        state.when(
          initial: () {},
          error: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('An error occurred'),
                duration: Duration(seconds: 1),
              ),
            );
          },
          ok: () {
            context.read<GetFavoritesBloc>().add(
                  const GetFavoritesEvent.get(),
                );
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Toogled as favorited'),
                duration: Duration(seconds: 1),
              ),
            );
          },
        );
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        body: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.arrow_back_rounded),
              ),
              automaticallyImplyLeading: false,
              elevation: 0,
              stretch: true,
              pinned: true,
              snap: true,
              floating: true,
              expandedHeight: 250,
              centerTitle: true,
              title: Text(widget.serie.name),
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    ImageComponent(
                      image: widget.serie.image,
                      betterQuality: true,
                    ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(8),
              sliver: SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          flex: 10,
                          child: InformativeText(
                            text: widget.serie.name,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: kNanoPadding),
                          child: Column(
                            children: [
                              IconButton(
                                icon: Icon(
                                  Icons.favorite,
                                  color: Theme.of(context).primaryColor,
                                ),
                                onPressed: () {
                                  context.read<FavoritesBloc>().add(
                                        FavoritesEvent.add(widget.serie),
                                      );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children:
                            widget.serie.genres.map(SerieGenre.new).toList(),
                      ),
                    ),
                    Summary(summary: widget.serie.summary),
                    SerieSchedule(widget.serie.schedule),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(child: SerieSeasons(widget.serie)),
            const SliverPadding(padding: EdgeInsets.all(kBigPadding)),
          ],
        ),
      ),
    );
  }
}

class SerieSeasons extends StatefulWidget {
  const SerieSeasons(
    this.serie, {
    super.key,
  });

  final TVSerie serie;

  @override
  State<SerieSeasons> createState() => _SerieSeasonsState();
}

class _SerieSeasonsState extends State<SerieSeasons> {
  @override
  void initState() {
    super.initState();
    context.read<SerieSeasonsBloc>().add(
          SerieSeasonsEvent.load(
            serie: widget.serie,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SerieSeasonsBloc, SerieSeasonsState>(
      builder: (context, state) {
        return state.maybeWhen(
          orElse: () => const Padding(
            padding: EdgeInsets.all(kBigPadding),
            child: AppLoader(),
          ),
          loaded: (seasons) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: seasons.map(SeasonItem.new).toList(),
            );
          },
          failed: (_) => const GenericError(),
        );
      },
    );
  }
}
