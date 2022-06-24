// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:http/http.dart';
import 'package:maze_tv/constants.dart';
import 'package:maze_tv/data/usecases/remote/get_series.dart';
import 'package:maze_tv/data/usecases/remote/search_series_by_name.dart';
import 'package:maze_tv/domain/entities/tv_serie.dart';
import 'package:maze_tv/infra/http_api_client_adapter.dart';
import 'package:maze_tv/l10n/l10n.dart';
import 'package:maze_tv/presentation/search/search_bloc.dart';
import 'package:maze_tv/presentation/series/series_bloc.dart';
import 'package:maze_tv/ui/pages/home_page.dart';
import 'package:maze_tv/ui/pages/series_details_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        //todo(acacio) -> inject
        BlocProvider(
          create: (_) => SeriesBloc(
            getSeries: GetTVSeriesImpl(
              apiClient: HttpAdapter(
                basePath: 'api.tvmaze.com',
                httpClient: Client(),
              ),
            ),
          )..add(const SeriesEvent.load()),
        ),
        BlocProvider(
          create: (_) => SearchBloc(
            searchSeriesByName: SearchSeriesByNameRemote(
              HttpAdapter(
                basePath: 'api.tvmaze.com',
                httpClient: Client(),
              ),
            ),
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
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
          if (settings.name == SeriesDetailsPage.routeName) {
            return PageRouteBuilder(
              pageBuilder: (_, __, ___) {
                return SeriesDetailsPage(
                  serie: settings.arguments! as TVSerie,
                );
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
          }
          return null;
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
