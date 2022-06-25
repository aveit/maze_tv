import 'package:flutter/material.dart';
import 'package:maze_tv/constants.dart';
import 'package:maze_tv/domain/entities/image.dart';
import 'package:maze_tv/domain/entities/tv_serie.dart';
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
            child: ImageComponent(
              image: serie.image,
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

class ImageComponent extends StatelessWidget {
  const ImageComponent({
    super.key,
    required this.image,
    this.betterQuality = false,
    this.shouldCheckRating = false,
  });

  final TVImage image;
  final bool betterQuality;
  final bool shouldCheckRating;

  double get imageSize {
    if (!shouldCheckRating) {
      return 200;
    }
    return 300;
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: ValueKey(image),
      child: image.containsImage
          ? FadeInImage.assetNetwork(
              placeholder: kPlaceholderPath,
              imageErrorBuilder: (_, __, ___) {
                return const AppImagePlaceHolder();
              },
              image: betterQuality ? image.original : image.medium,
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
      kPlaceholderPath,
      fit: BoxFit.cover,
    );
  }
}
