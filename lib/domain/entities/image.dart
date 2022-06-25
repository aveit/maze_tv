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

  bool get containsImage {
    return medium.isNotEmpty || original.isNotEmpty;
  }

  @override
  List<Object?> get props => [medium, original];
}
