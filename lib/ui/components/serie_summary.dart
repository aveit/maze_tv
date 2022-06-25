import 'package:flutter/material.dart';
import 'package:maze_tv/constants.dart';
import 'package:maze_tv/ui/components/informative_text.dart';
import 'package:styled_text/styled_text.dart';

class Summary extends StatelessWidget {
  const Summary({super.key, required this.summary});

  final String summary;

  @override
  Widget build(BuildContext context) {
    if (summary.isEmpty) {
      return const InformativeText(text: 'There is no summary.');
    }
    return Padding(
      padding: const EdgeInsets.all(kNanoPadding),
      child: StyledText(
        text: summary,
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
