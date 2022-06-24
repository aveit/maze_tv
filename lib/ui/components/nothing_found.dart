import 'package:flutter/material.dart';
import 'package:maze_tv/ui/components/informative_text.dart';

class NothingFound extends StatelessWidget {
  const NothingFound({super.key});

  @override
  Widget build(BuildContext context) {
    return const InformativeText(text: 'Nothing found');
  }
}
