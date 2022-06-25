import 'package:maze_tv/domain/entities/rating.dart';

class RatingModel {
  const RatingModel({this.average});
  factory RatingModel.fromJson(Map<String, dynamic> json) {
    return RatingModel(average: double.tryParse(json['average'].toString()));
  }

  final double? average;

  Rating toEntity() {
    return Rating(average: average ?? 0);
  }
}
