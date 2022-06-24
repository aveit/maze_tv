import 'package:equatable/equatable.dart';

class Country extends Equatable {
  const Country({
    required this.name,
    required this.code,
    required this.timezone,
  });

  factory Country.empty() {
    return const Country(name: '', code: '', timezone: '');
  }

  final String name;
  final String code;
  final String timezone;

  @override
  List<Object?> get props => [name, code, timezone];
}
