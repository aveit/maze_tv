import 'dart:convert';

import 'package:maze_tv/domain/entities/rating.dart';

class RatingModel {
  const RatingModel({
    this.average,
  });

  factory RatingModel.fromEntity(Rating entity) {
    return RatingModel(average: entity.average);
  }

  factory RatingModel.fromJson(Map<String, dynamic> json) {
    return RatingModel(average: double.tryParse(json['average'].toString()));
  }

  final double? average;

  Rating toEntity() {
    return Rating(average: average ?? 0);
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (average != null) {
      result.addAll({'average': average});
    }

    return result;
  }

  String toJson() => json.encode(toMap());
}
