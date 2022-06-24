import 'package:equatable/equatable.dart';

class TVImage extends Equatable {
  const TVImage({required this.medium, required this.original});

  factory TVImage.empty() {
    return const TVImage(
      medium: '',
      original: '',
    );
  }

  final String medium;
  final String original;

  @override
  List<Object?> get props => [medium, original];
}
