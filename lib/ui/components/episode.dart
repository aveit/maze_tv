import 'package:flutter/material.dart';
import 'package:maze_tv/constants.dart';
import 'package:maze_tv/domain/entities/serie_season.dart';

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
