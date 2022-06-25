import 'package:equatable/equatable.dart';

class Rating extends Equatable {
  const Rating({required this.average});

  factory Rating.empty() {
    return const Rating(average: 0);
  }

  final double average;

  @override
  List<Object?> get props => [average];
}
