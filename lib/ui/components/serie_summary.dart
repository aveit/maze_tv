import 'package:flutter/material.dart';
import 'package:maze_tv/constants.dart';
import 'package:maze_tv/domain/entities/tv_serie.dart';
import 'package:maze_tv/ui/components/informative_text.dart';
import 'package:styled_text/styled_text.dart';

class SerieSummary extends StatelessWidget {
  const SerieSummary({super.key, required this.serie});

  final TVSerie serie;

  @override
  Widget build(BuildContext context) {
    if (serie.summary.isEmpty) {
      return const InformativeText(text: 'There is no summary for this serie');
    }
    return Padding(
      padding: const EdgeInsets.all(kNanoPadding),
      child: StyledText(
        text: serie.summary,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w300,
        ),
        tags: {
          'b': StyledTextTag(
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
        },
      ),
    );
  }
}
