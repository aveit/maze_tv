import 'package:flutter/material.dart';
import 'package:maze_tv/ui/components/informative_text.dart';

class GenericError extends StatelessWidget {
  const GenericError({super.key});

  @override
  Widget build(BuildContext context) {
    return const InformativeText(text: 'An error happened');
  }
}
