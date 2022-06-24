import 'package:equatable/equatable.dart';
import 'package:maze_tv/domain/entities/country.dart';

class Network extends Equatable {
  const Network({
    required this.id,
    required this.name,
    required this.country,
    required this.officialSite,
  });

  factory Network.empty() {
    return Network(
      id: 0,
      name: '',
      country: Country.empty(),
      officialSite: '',
    );
  }

  final int id;
  final String name;
  final Country country;
  final String officialSite;

  @override
  List<Object?> get props => [id, name, country, officialSite];
}
