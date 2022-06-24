import 'package:flutter/material.dart';
import 'package:maze_tv/constants.dart';
import 'package:maze_tv/domain/entities/tv_serie.dart' hide TVImage;
import 'package:maze_tv/ui/pages/series_details_page.dart';

class SeriePoster extends StatelessWidget {
  const SeriePoster({
    required this.serie,
    super.key,
    this.shouldCheckRating = false,
  });

  final TVSerie serie;
  final bool shouldCheckRating;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          SeriesDetailsPage.routeName,
          arguments: serie,
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(16),
            ),
            child: SerieImage(
              serie: serie,
              shouldCheckRating: shouldCheckRating,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: kSmallPadding),
            child: Text(serie.name),
          ),
        ],
      ),
    );
  }
}

class SerieImage extends StatelessWidget {
  const SerieImage({
    super.key,
    required this.serie,
    this.betterQuality = false,
    this.shouldCheckRating = false,
  });

  final TVSerie serie;
  final bool betterQuality;
  final bool shouldCheckRating;

  double get imageSize {
    if (!shouldCheckRating || serie.rating.average < 7) {
      return 200;
    }
    return 300;
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: ValueKey(serie),
      child: serie.containsImage
          ? FadeInImage.assetNetwork(
              placeholder: 'assets/images/placeholder.png',
              image: betterQuality ? serie.image.original : serie.imageUrl!,
              fit: BoxFit.cover,
              height: imageSize,
            )
          : AppImagePlaceHolder(size: imageSize),
    );
  }
}

class AppImagePlaceHolder extends StatelessWidget {
  const AppImagePlaceHolder({
    super.key,
    this.size = 200,
  });

  final double size;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/placeholder.png',
      fit: BoxFit.cover,
    );
  }
}
