import 'package:flutter/material.dart';
import 'package:maze_tv/constants.dart';
import 'package:maze_tv/domain/entities/serie_season.dart';
import 'package:maze_tv/ui/components/episode.dart';
import 'package:maze_tv/ui/components/informative_text.dart';

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
                          children: season.episodes.map(
                            (episode) {
                              return EpisodeWidget(
                                episode: episode,
                              );
                            },
                          ).toList(),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 200,
                      width: 150,
                      child: season.image.medium.isEmpty
                          ? Image.asset(kPlaceholderPath)
                          : FadeInImage.assetNetwork(
                              placeholder: kPlaceholderPath,
                              image: season.image.medium,
                            ),
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
