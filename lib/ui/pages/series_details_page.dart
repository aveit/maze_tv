import 'package:flutter/material.dart';
import 'package:maze_tv/domain/entities/tv_serie.dart' hide Image;
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
        ],
      ),
    );
  }
}
