import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maze_tv/presentation/search/search_bloc.dart';
import 'package:maze_tv/ui/components/app_loader.dart';
import 'package:maze_tv/ui/components/generic_error.dart';
import 'package:maze_tv/ui/components/informative_text.dart';
import 'package:maze_tv/ui/components/nothing_found.dart';
import 'package:maze_tv/ui/components/serie_poster.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: 'Search series by Name',
              icon: Icon(
                Icons.search,
                color: Theme.of(context).primaryColor,
              ),
              border: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).primaryColor,
                ),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).primaryColor,
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            cursorColor: Theme.of(context).primaryColor,
            onSubmitted: (value) {
              context.read<SearchBloc>().add(
                    SearchEvent.search(serieName: value),
                  );
            },
          ),
          const SizedBox(height: 24),
          BlocBuilder<SearchBloc, SearchState>(
            builder: (context, state) {
              return state.when(
                loading: () {
                  return const AppLoader();
                },
                loaded: (series) {
                  if (series.isEmpty) {
                    return const NothingFound();
                  }
                  return Expanded(
                    child: GridView.count(
                      crossAxisCount: 1,
                      children: series.map((current) {
                        return SeriePoster(serie: current);
                      }).toList(),
                    ),
                  );
                },
                failed: (failure) {
                  return const GenericError();
                },
                initial: () {
                  return const InformativeText(text: 'Nothing to show yet!');
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
