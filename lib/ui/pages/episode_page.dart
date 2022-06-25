import 'package:flutter/material.dart';
import 'package:maze_tv/constants.dart';
import 'package:maze_tv/domain/entities/episode.dart';
import 'package:maze_tv/ui/components/informative_text.dart';
import 'package:maze_tv/ui/components/serie_poster.dart';
import 'package:maze_tv/ui/components/serie_summary.dart';

class EpisodePage extends StatelessWidget {
  const EpisodePage(this.episode, {super.key});
  static const routeName = 'EpisodePage';

  final Episode episode;

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
                  ImageComponent(
                    image: episode.image,
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
                          text: '${episode.number} - ${episode.shortName}',
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: kNanoPadding),
                        child: Column(
                          children: [
                            Icon(
                              Icons.star_rounded,
                              color: Theme.of(context).primaryColor,
                            ),
                            Text(
                              '${episode.rating.average}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'From Season ${episode.season} | ${episode.runtime} mins',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const Divider(),
                  Summary(summary: episode.summary),
                  const Divider(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
