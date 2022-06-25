import 'package:flutter/material.dart';
import 'package:maze_tv/constants.dart';
import 'package:maze_tv/domain/entities/episode.dart';
import 'package:maze_tv/ui/pages/episode_page.dart';

class EpisodeWidget extends StatelessWidget {
  const EpisodeWidget({
    super.key,
    required this.episode,
  });

  final Episode episode;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          EpisodePage.routeName,
          arguments: episode,
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('${episode.number} - ${episode.shortName}'),
          Container(
            width: 200,
            padding: const EdgeInsets.symmetric(vertical: kSmallPadding),
            margin: const EdgeInsets.only(right: kSmallPadding),
            child: episode.image.medium.isEmpty
                ? Image.asset(
                    kPlaceholderPath,
                    height: 150,
                  )
                : FadeInImage.assetNetwork(
                    height: 150,
                    placeholder: kPlaceholderPath,
                    image: episode.image.medium,
                  ),
          ),
        ],
      ),
    );
  }
}
