import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieetlite/src/core/extensions/context_extension.dart';
import 'package:movieetlite/src/core/widgets/other/centered_progress_indicator.dart';
import 'package:movieetlite/src/features/trends/presentation/trend_movies/bloc/trend_movies_bloc.dart';
import 'package:movieetlite/src/features/trends/presentation/trends/view/trend_list.dart';

class TrendMoviesPage extends StatelessWidget {
  const TrendMoviesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrendMoviesBloc, TrendMoviesState>(
      builder: (context, state) {
        if (state.status == TrendMovieStatus.initial) {
          return const CenteredProgressIndicator();
        }
        return Column(
          children: [
            Expanded(
              child: TrendList(trendList: state.trendMovies),
            ),
            if (state.status == TrendMovieStatus.loading)
              Padding(
                padding: EdgeInsets.symmetric(vertical: context.highPadding),
                child: const CircularProgressIndicator(key: Key('bottomLoader')),
              ),
          ],
        );
      },
    );
  }
}
