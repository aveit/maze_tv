import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maze_tv/constants.dart';
import 'package:maze_tv/domain/entities/serie_season.dart';
import 'package:maze_tv/domain/entities/tv_serie.dart';
import 'package:maze_tv/presentation/serie_seasons/serie_seasons_bloc.dart';
import 'package:maze_tv/ui/components/app_loader.dart';
import 'package:maze_tv/ui/components/generic_error.dart';
import 'package:maze_tv/ui/components/informative_text.dart';
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
    return Scaffold(
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
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: const [
                StretchMode.blurBackground,
                StretchMode.zoomBackground
              ],
              background: Stack(
                fit: StackFit.expand,
                children: [
                  SerieImage(
                    serie: widget.serie,
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
                  InformativeText(text: widget.serie.name),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children:
                          widget.serie.genres.map(SerieGenre.new).toList(),
                    ),
                  ),
                  SerieSummary(serie: widget.serie),
                  SerieSchedule(widget.serie.schedule),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(child: SerieSeasons(widget.serie)),
          const SliverPadding(padding: EdgeInsets.all(kBigPadding)),
        ],
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

class SeasonItem extends StatelessWidget {
  const SeasonItem(this.season, {super.key});
  final SerieSeason season;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kNanoPadding),
      child: ExpansionTile(
        title: Row(
          children: [
            InformativeText(
              text: 'Season ${season.number}',
              color: Theme.of(context).primaryColor,
              fontSize: 24,
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(left: kSmallPadding),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text(
                    season.name,
                    style: const TextStyle(
                      color: Colors.black38,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: kSmallPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 150),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            EpisodeWidget(season: season),
                            EpisodeWidget(season: season),
                            EpisodeWidget(season: season),
                            EpisodeWidget(season: season),
                            EpisodeWidget(season: season),
                            EpisodeWidget(season: season),
                            EpisodeWidget(season: season),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 200,
                      width: 150,
                      child: season.image.medium.isEmpty
                          ? Image.asset('assets/images/placeholder.png')
                          : Image.network(season.image.medium),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class EpisodeWidget extends StatelessWidget {
  const EpisodeWidget({
    super.key,
    required this.season,
  });

  final SerieSeason season;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      padding: const EdgeInsets.symmetric(vertical: kSmallPadding),
      margin: const EdgeInsets.only(right: kSmallPadding),
      child: season.image.medium.isEmpty
          ? Image.asset('assets/images/placeholder.png')
          : Image.network(season.image.medium),
    );
  }
}
