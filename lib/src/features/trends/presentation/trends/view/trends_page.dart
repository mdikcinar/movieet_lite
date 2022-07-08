import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieetlite/src/core/extensions/context_extension.dart';
import 'package:movieetlite/src/features/trends/data/trends_service.dart';
import 'package:movieetlite/src/features/trends/presentation/trend_movies/trend_movies.dart';
import 'package:movieetlite/src/features/trends/presentation/trend_series/trend_series.dart';
import 'package:movieetlite/src/features/trends/presentation/trends/cubit/trends_cubit.dart';
import 'package:movieetlite/src/features/trends/presentation/trends/trends.dart';

class TrendsPage extends StatelessWidget {
  const TrendsPage(this._trendsService, {super.key});

  final TrendsService _trendsService;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => TrendsCubit()),
        BlocProvider(create: (context) => TrendMoviesBloc(_trendsService)..add(TrendMoviesFetched())),
        BlocProvider(create: (context) => TrendSeriesBloc(_trendsService)),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Movieet Lite',
            style: TextStyle(fontFamily: 'Fuggles', fontSize: context.height * 0.05),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: BlocBuilder<TrendsCubit, TrendsState>(
          builder: (context, state) {
            return Column(
              children: [
                Row(
                  children: [
                    CategoryNameButton(
                      isSelected: state == TrendsState.movies,
                      text: 'Movies',
                      onTap: () => context.read<TrendsCubit>().changeTrendsState(TrendsState.movies),
                    ),
                    CategoryNameButton(
                      isSelected: state == TrendsState.serries,
                      text: 'Series',
                      onTap: () {
                        context.read<TrendsCubit>().changeTrendsState(TrendsState.serries);
                        final trendSeriesBloc = context.read<TrendSeriesBloc>();
                        if (trendSeriesBloc.state.trendSeries.isEmpty) trendSeriesBloc.add(TrendSeriesFetched());
                      },
                    ),
                  ],
                ),
                SizedBox(height: context.normalPadding),
                Expanded(child: state == TrendsState.movies ? const TrendMoviesList() : const TrendSeriesList()),
              ],
            );
          },
        ),
      ),
    );
  }
}

class CategoryNameButton extends StatelessWidget {
  final bool isSelected;
  final String text;
  final VoidCallback onTap;
  const CategoryNameButton({
    Key? key,
    required this.isSelected,
    required this.text,
    required this.onTap,
  }) : super(key: key);

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
              child: SizedBox(height: 1),
            )
          ],
        ),
      ),
    );
  }
}
