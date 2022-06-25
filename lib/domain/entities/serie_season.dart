import 'package:equatable/equatable.dart';
import 'package:maze_tv/domain/entities/image.dart';
import 'package:maze_tv/domain/entities/links.dart';
import 'package:maze_tv/domain/entities/network.dart';

class SerieSeason extends Equatable {
  const SerieSeason({
    required this.id,
    required this.url,
    required this.number,
    required this.name,
    required this.episodeOrder,
    required this.premiereDate,
    required this.endDate,
    required this.network,
    required this.image,
    required this.summary,
    required this.links,
  });

  factory SerieSeason.empty({
    int? id,
    String? url,
    int? number,
    String? name,
    int? episodeOrder,
    String? premiereDate,
    String? endDate,
    String? summary,
    Network? network,
    TVImage? image,
    Links? links,
  }) {
    return SerieSeason(
      id: id ?? 0,
      url: url ?? '',
      number: number ?? 0,
      name: name ?? '',
      episodeOrder: episodeOrder ?? 0,
      premiereDate: premiereDate ?? '',
      endDate: endDate ?? '',
      summary: summary ?? '',
      network: network ?? Network.empty(),
      image: image ?? TVImage.empty(),
      links: links ?? Links.empty(),
    );
  }

  final int id;
  final String url;
  final int number;
  final String name;
  final int episodeOrder;
  final String premiereDate;
  final String endDate;
  final String summary;
  final Network network;
  final TVImage image;
  final Links links;

  @override
  List<Object?> get props => [
        id,
        url,
        number,
        name,
        episodeOrder,
        premiereDate,
        endDate,
        summary,
        network,
        image,
        links,
      ];
}
