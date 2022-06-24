import 'package:flutter/material.dart';
import 'package:maze_tv/domain/entities/tv_serie.dart' hide TVImage;
import 'package:maze_tv/ui/pages/series_details_page.dart';

class SeriePoster extends StatelessWidget {
  const SeriePoster({
    required this.serie,
    super.key,
  });

  final TVSerie serie;

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
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(16),
            ),
            child: SerieImage(serie: serie),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(serie.name),
          ),
          // RatingBar(
          //   valueKey: serie.id.toString(),
          //   rating: serie.rating.average,
          //   size: 25,
          // ),
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
  });

  final TVSerie serie;
  final bool betterQuality;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: ValueKey(serie),
      child: serie.containsImage
          ? FadeInImage.assetNetwork(
              placeholder: 'assets/images/placeholder.png',
              image: betterQuality ? serie.image.original : serie.imageUrl!,
              fit: BoxFit.cover,
            )
          : const AppImagePlaceHolder(),
    );
  }
}

class AppImagePlaceHolder extends StatelessWidget {
  const AppImagePlaceHolder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/placeholder.png',
      fit: BoxFit.cover,
    );
  }
}
