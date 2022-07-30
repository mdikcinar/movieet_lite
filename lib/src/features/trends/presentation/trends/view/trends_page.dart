import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieetlite/src/core/extensions/context_extension.dart';
import 'package:movieetlite/src/core/widgets/other/centered_progress_indicator.dart';
import 'package:movieetlite/src/features/trends/presentation/trends/bloc/trends_bloc.dart';
import 'package:movieetlite/src/features/trends/presentation/trends/view/trend_list.dart';

class TrendsPage extends StatelessWidget {
  const TrendsPage(this.trendsBloc, {super.key});
  final TrendsBloc trendsBloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TrendsBloc>(
      create: (context) => trendsBloc..add(TrendMoviesFetched()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Movieet Lite',
            style: TextStyle(fontFamily: 'Fuggles', fontSize: context.height * 0.05),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: BlocBuilder<TrendsBloc, TrendsState>(
          buildWhen: (previous, current) => current.trendsTab != previous.trendsTab,
          builder: (context, state) {
            return Column(
              children: [
                Row(
                  children: [
                    CategoryNameButton(
                      key: const Key('movies-tab-button'),
                      isSelected: state.trendsTab == TrendsTab.movies,
                      text: 'Movies',
                      onTap: () => context.read<TrendsBloc>().add(TrendMoviesTabViewed()),
                    ),
                    CategoryNameButton(
                      key: const Key('series-tab-button'),
                      isSelected: state.trendsTab == TrendsTab.series,
                      text: 'Series',
                      onTap: () {
                        final trendSeriesBloc = context.read<TrendsBloc>()..add(TrendSeriesTabViewed());
                        if (state.trendSeries.isEmpty) trendSeriesBloc.add(TrendSeriesFetched());
                      },
                    ),
                  ],
                ),
                SizedBox(height: context.normalPadding),
                Expanded(
                  child: BlocBuilder<TrendsBloc, TrendsState>(
                    buildWhen: (previous, current) =>
                        current.trendsTab != previous.trendsTab ||
                        (current.trendsTab == TrendsTab.movies
                            ? current.moviesStatus != previous.moviesStatus
                            : current.seriesStatus != previous.seriesStatus),
                    builder: (context, state) {
                      if (state.trendsTab == TrendsTab.movies
                          ? state.moviesStatus == TrendsStatus.initial
                          : state.seriesStatus == TrendsStatus.initial) {
                        return const CenteredProgressIndicator();
                      }
                      return TrendTab(
                        key: Key(state.trendsTab == TrendsTab.movies ? 'trend-movie-tab' : 'trend-series-tab'),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class CategoryNameButton extends StatelessWidget {
  const CategoryNameButton({
    super.key,
    required this.isSelected,
    required this.text,
    required this.onTap,
  });
  final bool isSelected;
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(text, textAlign: TextAlign.center),
            ),
            DecoratedBox(
              decoration: BoxDecoration(color: isSelected ? Colors.black : Colors.transparent),
              child: const SizedBox(height: 1),
            )
          ],
        ),
      ),
    );
  }
}

class TrendTab extends StatelessWidget {
  const TrendTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: BlocBuilder<TrendsBloc, TrendsState>(
            buildWhen: (previous, current) =>
                current.trendsTab != previous.trendsTab ||
                (current.trendsTab == TrendsTab.movies
                    ? current.trendMovies != previous.trendMovies
                    : current.trendSeries != previous.trendSeries),
            builder: (context, state) {
              return TrendList(
                key: Key(state.trendsTab == TrendsTab.movies ? 'trend-movie-list' : 'trend-series-list'),
                trendList: state.trendsTab == TrendsTab.movies ? state.trendMovies : state.trendSeries,
                onBottom: () => context
                    .read<TrendsBloc>()
                    .add(state.trendsTab == TrendsTab.movies ? TrendMoviesFetched() : TrendSeriesFetched()),
              );
            },
          ),
        ),
        BlocBuilder<TrendsBloc, TrendsState>(
          buildWhen: (previous, current) => current.trendsTab == TrendsTab.movies
              ? current.moviesStatus != previous.moviesStatus
              : current.seriesStatus != previous.seriesStatus,
          builder: (context, state) {
            if (state.trendsTab == TrendsTab.movies
                ? state.moviesStatus != TrendsStatus.loading
                : state.seriesStatus != TrendsStatus.loading) {
              return const SizedBox();
            }
            return Padding(
              padding: EdgeInsets.symmetric(vertical: context.highPadding),
              child: const CircularProgressIndicator(key: Key('bottom-loader')),
            );
          },
        ),
      ],
    );
  }
}
