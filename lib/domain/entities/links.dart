import 'package:equatable/equatable.dart';

class Links extends Equatable {
  const Links({required this.self, required this.previousepisode});

  factory Links.empty() {
    return Links(
      self: Self.empty(),
      previousepisode: Self.empty(),
    );
  }

  final Self self;
  final Self previousepisode;

  @override
  List<Object?> get props => [self, previousepisode];
}

class Self extends Equatable {
  const Self({required this.href});

  factory Self.empty() {
    return const Self(href: '');
  }

  final String href;

  @override
  List<Object?> get props => [href];
}
