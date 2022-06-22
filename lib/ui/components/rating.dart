import 'package:flutter/material.dart';

class RatingBar extends StatelessWidget {
  const RatingBar({
    required this.rating,
    required this.size,
    required this.valueKey,
    super.key,
  });

  final double rating;
  final double size;
  final String valueKey;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(
        Radius.circular(16),
      ),
      child: Container(
        padding: const EdgeInsets.all(8),
        color: Colors.orange.shade100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: List.generate(10, (index) {
            return Hero(
              tag: 'heroTag$valueKey$index',
              createRectTween: (begin, end) {
                return _createRectTween(begin, end, index);
              },
              child: Icon(
                index < rating ? Icons.star : Icons.star_border,
                color: Colors.orange,
                size: size,
              ),
            );
          }),
        ),
      ),
    );
  }

  static RectTween _createRectTween(Rect? begin, Rect? end, int index) {
    switch (index) {
      case 0:
      case 1:
        return CustomRectTween(
          begin: begin,
          end: end,
          cubic: Curves.easeOutExpo,
        );
      case 2:
      case 3:
        return CustomRectTween(
          begin: begin,
          end: end,
          cubic: Curves.easeOutQuint,
        );
      case 4:
      case 5:
        return CustomRectTween(
          begin: begin,
          end: end,
          cubic: Curves.easeOutQuart,
        );
      case 6:
      case 7:
        return CustomRectTween(
          begin: begin,
          end: end,
          cubic: Curves.easeOutCubic,
        );
      case 8:
      case 9:
      default:
        return CustomRectTween(
          begin: begin,
          end: end,
          cubic: Curves.easeOutQuad,
        );
    }
  }
}

class CustomRectTween extends RectTween {
  CustomRectTween({
    super.begin,
    super.end,
    required Cubic cubic,
  }) {
    _cubic = cubic;
  }

  late Cubic _cubic;

  @override
  Rect lerp(double t) {
    double height = (end?.top ?? 0) - (begin?.top ?? 0);
    double width = (end?.left ?? 0) - (begin?.left ?? 0);

    double transformedY = _cubic.transform(t);

    double animatedX = (begin?.left ?? 0) + (t * width);
    double animatedY = (begin?.top ?? 0) + (transformedY * height);

    return Rect.fromLTWH(animatedX, animatedY, 1, 1);
  }
}
