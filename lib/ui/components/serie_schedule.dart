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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.timer,
                color: Colors.black38,
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
                  child: Text('$e | '),
                );
              }).toList(),
            ],
          ),
        ],
      ),
    );
  }
}
