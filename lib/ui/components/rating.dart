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
    late Cubic curve;
    switch (index) {
      case 0:
      case 1:
        curve = Curves.easeOutExpo;
        break;
      case 2:
      case 3:
        curve = Curves.easeOutQuint;
        break;
      case 4:
      case 5:
        curve = Curves.easeOutQuart;
        break;
      case 6:
      case 7:
        curve = Curves.easeOutCubic;
        break;
      case 8:
      case 9:
      default:
        curve = Curves.easeOutQuad;
        break;
    }
    return CustomRectTween(
      begin: begin,
      end: end,
      cubic: curve,
    );
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
    final height = (end?.top ?? 0) - (begin?.top ?? 0);
    final width = (end?.left ?? 0) - (begin?.left ?? 0);

    final transformedY = _cubic.transform(t);

    final animatedX = (begin?.left ?? 0) + (t * width);
    final animatedY = (begin?.top ?? 0) + (transformedY * height);

    return Rect.fromLTWH(animatedX, animatedY, 1, 1);
  }
}
