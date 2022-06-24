import 'package:flutter/material.dart';

class InformativeText extends StatelessWidget {
  const InformativeText({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w600,
        color: Colors.black54,
      ),
    );
  }
}
