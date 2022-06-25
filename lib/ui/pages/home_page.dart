import 'package:flutter/material.dart';
import 'package:maze_tv/presentation/favorites/get/get_favorites_bloc.dart';
import 'package:maze_tv/ui/pages/favorites_page.dart';
import 'package:maze_tv/ui/pages/search/search_page.dart';
import 'package:maze_tv/ui/pages/series_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  static const pages = [
    SeriesPage(),
    FavoritesPage(),
    SearchPage(),
  ];

  late final TabController controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: pages.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tv Maze',
          style: TextStyle(
            fontSize: 22,
          ),
        ),
        bottom: TabBar(
          isScrollable: true,
          controller: controller,
          indicatorColor: Theme.of(context).primaryColorLight,
          onTap: (index) {
            if (index == 1) {
              context.read<GetFavoritesBloc>().add(
                    const GetFavoritesEvent.get(),
                  );
            }
          },
          tabs: [
            Tab(
              height: 60,
              child: Column(
                children: const [
                  Icon(Icons.movie_rounded, size: 40),
                  Text('Movies'),
                ],
              ),
            ),
            Tab(
              height: 60,
              child: Column(
                children: const [
                  Icon(Icons.favorite_rounded, size: 40),
                  Text('Favs'),
                ],
              ),
            ),
            Tab(
              height: 60,
              child: Column(
                children: const [
                  Icon(
                    Icons.search_rounded,
                    size: 40,
                  ),
                  Text('Search'),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: TabBarView(
          controller: controller,
          physics: const NeverScrollableScrollPhysics(),
          children: pages,
        ),
      ),
    );
  }
}
