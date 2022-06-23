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
import 'package:maze_tv/data/usecases/remote/get_series.dart';
import 'package:maze_tv/domain/entities/tv_serie.dart';
import 'package:maze_tv/infra/http_api_client_adapter.dart';
import 'package:maze_tv/l10n/l10n.dart';
import 'package:maze_tv/presentation/bloc/series_bloc.dart';
import 'package:maze_tv/ui/pages/series_details_page.dart';
import 'package:maze_tv/ui/pages/series_page.dart';

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
                basePath: 'https://api.tvmaze.com',
                httpClient: Client(),
              ),
            ),
          )..add(const SeriesEvent.load()),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          appBarTheme: const AppBarTheme(color: Color(0xFF13B9FF)),
          colorScheme: ColorScheme.fromSwatch(
            accentColor: const Color(0xFF13B9FF),
          ),
        ),
        onGenerateRoute: (settings) {
          if (settings.name == SeriesDetailsPage.routeName) {
            return PageRouteBuilder(
              pageBuilder: (_, __, ___) {
                return SeriesDetailsPage(
                  serie: settings.arguments as TVSerie,
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
              transitionDuration: const Duration(seconds: 1),
            );
          }
        },
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        home: const SeriesPage(),
      ),
    );
  }
}
