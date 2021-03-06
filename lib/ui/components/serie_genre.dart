import 'package:flutter/material.dart';
import 'package:maze_tv/constants.dart';

class SerieGenre extends StatelessWidget {
  const SerieGenre(
    this.genre, {
    super.key,
  });

  final String genre;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kNanoPadding),
      child: RawChip(
        backgroundColor: Colors.grey.shade300,
        padding: const EdgeInsets.all(8),
        label: Text(
          genre,
          style: TextStyle(
            fontSize: 16,
            color: Theme.of(context).primaryColor.withOpacity(.7),
          ),
        ),
      ),
    );
  }
}
