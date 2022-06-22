import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:maze_tv/domain/entities/tv_serie.dart' hide Image;
import 'package:maze_tv/ui/components/rating.dart';

class SeriesDetailsPage extends StatefulWidget {
  static const routeName = 'SeriesDetailsPage';

  final TVSerie serie;

  const SeriesDetailsPage({super.key, required this.serie});

  @override
  State<SeriesDetailsPage> createState() => _SeriesDetailsPageState();
}

class _SeriesDetailsPageState extends State<SeriesDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff3f3f3),
      extendBodyBehindAppBar: true,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        // controller: controller,
        slivers: [
          SliverAppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.arrow_back_rounded),
            ),
            backgroundColor: Color(0xfff3f3f3),
            automaticallyImplyLeading: false,
            elevation: 0,
            stretch: true,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: const [
                StretchMode.blurBackground,
                StretchMode.zoomBackground
              ],
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Hero(
                    tag: ValueKey(widget.serie),
                    child: Image.network(
                      widget.serie.image.original,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(16),
                    child: Positioned(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: RatingBar(
                          valueKey: widget.serie.id.toString(),
                          rating: widget.serie.rating.average,
                          size: 25,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              height: 50,
              child: Stack(
                children: [],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
