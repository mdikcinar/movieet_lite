import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieetlite/src/core/extensions/context_extension.dart';
import 'package:movieetlite/src/features/trends/data/trends_service.dart';
import 'package:movieetlite/src/features/trends/presentation/trend_movies/bloc/trend_movies_bloc.dart';
import 'package:movieetlite/src/features/trends/presentation/trend_movies/view/trend_movies_page.dart';
import 'package:movieetlite/src/features/trends/presentation/trend_series/trend_movies.dart';
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
        body: BlocBuilder<TrendsCubit, TrendsView>(
          builder: (context, state) {
            return Column(
              children: [
                Row(
                  children: [
                    CategoryNameButton(
                      isSelected: state == TrendsView.movies,
                      text: 'Movies',
                      onTap: () => context.read<TrendsCubit>().changeTrendsView(TrendsView.movies),
                    ),
                    CategoryNameButton(
                      isSelected: state == TrendsView.serries,
                      text: 'Series',
                      onTap: () => context.read<TrendsCubit>().changeTrendsView(TrendsView.serries),
                    ),
                  ],
                ),
                SizedBox(height: context.normalPadding),
                Expanded(child: state == TrendsView.movies ? const TrendMoviesPage() : const TrendSeriesPage()),
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
