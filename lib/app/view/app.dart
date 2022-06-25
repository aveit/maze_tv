// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:localstorage/localstorage.dart';
import 'package:maze_tv/constants.dart';
import 'package:maze_tv/data/usecases/local/save_serie_on_favorites.dart';
import 'package:maze_tv/data/usecases/remote/get_season_episodes.dart';
import 'package:maze_tv/data/usecases/remote/get_serie_seasons.dart';
import 'package:maze_tv/data/usecases/remote/get_series.dart';
import 'package:maze_tv/data/usecases/remote/search_series_by_name.dart';
import 'package:maze_tv/domain/entities/episode.dart';
import 'package:maze_tv/domain/entities/tv_serie.dart';
import 'package:maze_tv/infra/http_api_client_adapter.dart';
import 'package:maze_tv/infra/local_storage_client_adapter.dart';
import 'package:maze_tv/l10n/l10n.dart';
import 'package:maze_tv/main/composites/get_seasons_with_episodes.dart';
import 'package:maze_tv/presentation/favorites/bloc/favorites_bloc.dart';
import 'package:maze_tv/presentation/search/search_bloc.dart';
import 'package:maze_tv/presentation/serie_seasons/serie_seasons_bloc.dart';
import 'package:maze_tv/presentation/series/series_bloc.dart';
import 'package:maze_tv/ui/pages/episode_page.dart';
import 'package:maze_tv/ui/pages/home_page.dart';
import 'package:maze_tv/ui/pages/series_details_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final apiClient = HttpAdapter(
      basePath: 'api.tvmaze.com',
      httpClient: Client(),
    );
    return MultiBlocProvider(
      providers: [
        //todo(acacio) -> inject
        BlocProvider(
          create: (_) => SeriesBloc(
            getSeries: GetTVSeriesImpl(apiClient: apiClient),
          )..add(const SeriesEvent.loadNextPage()),
        ),
        BlocProvider(
          create: (_) => SearchBloc(
            searchSeriesByName: SearchSeriesByNameRemote(apiClient),
          ),
        ),
        BlocProvider(
          create: (_) => SerieSeasonsBloc(
            getSeriesSeasons: GetSeasonsWithEpisodes(
              getEpisodes: GetSeasonsEpisodesRemote(apiClient),
              getSeasons: GetSerieSeasonsRemote(apiClient),
            ),
          ),
        ),
        BlocProvider(
          create: (_) => FavoritesBloc(
            saveSerieOnFavorites: SaveSerieOnFavoritesLocal(
              LocalStorageAdapter(
                LocalStorage('db'),
              ),
            ),
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: GoogleFonts.openSansTextTheme(),
          appBarTheme: const AppBarTheme(color: kPrimaryColor),
          colorScheme: ColorScheme.fromSwatch(
            accentColor: kPrimaryColor,
            primaryColorDark: kPrimaryColor,
          ),
          primaryColor: kPrimaryColor,
          progressIndicatorTheme: ProgressIndicatorThemeData(
            circularTrackColor: kPrimaryColor.withOpacity(.15),
            color: kPrimaryColor,
          ),
        ),
        onGenerateRoute: (settings) {
          late final Widget page;
          if (settings.name == SeriesDetailsPage.routeName) {
            page = SeriesDetailsPage(
              serie: settings.arguments! as TVSerie,
            );
          } else if (settings.name == EpisodePage.routeName) {
            page = EpisodePage(
              settings.arguments! as Episode,
            );
          }
          return PageRouteBuilder(
            pageBuilder: (_, __, ___) {
              return page;
            },
            transitionsBuilder: (_, animation, __, child) {
              return Align(
                child: SizeTransition(
                  sizeFactor: animation,
                  child: child,
                ),
              );
            },
            transitionDuration: const Duration(milliseconds: 500),
          );
        },
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        home: const HomePage(),
      ),
    );
  }
}
