import 'package:flutter/material.dart';

class InformativeText extends StatelessWidget {
  const InformativeText({
    super.key,
    required this.text,
    this.color,
    this.fontSize,
  });

  final String text;
  final Color? color;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: TextOverflow.fade,
      style: TextStyle(
        fontSize: fontSize ?? 32,
        color: color ?? Colors.black54,
      ),
    );
  }
}
