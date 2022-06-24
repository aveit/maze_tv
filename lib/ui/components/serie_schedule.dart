import 'package:flutter/material.dart';
import 'package:maze_tv/constants.dart';
import 'package:maze_tv/domain/entities/tv_serie.dart';

class SerieSchedule extends StatelessWidget {
  const SerieSchedule(
    this.schedule, {
    super.key,
  });

  final Schedule schedule;

  @override
  Widget build(BuildContext context) {
    if (schedule.time.isEmpty) {
      return const SizedBox.shrink();
    }
    return Padding(
      padding: const EdgeInsets.all(kNanoPadding),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            Icon(
              Icons.timer,
              color: Theme.of(context).primaryColor,
            ),
            const SizedBox(width: kNanoSpace),
            Text(
              schedule.time,
              style: const TextStyle(
                fontWeight: FontWeight.w400,
              ),
            ),
            const Text(' | '),
            ...schedule.days.map((e) {
              return Padding(
                padding: const EdgeInsets.all(kNanoPadding),
                child: Text(
                  '$e | ',
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
