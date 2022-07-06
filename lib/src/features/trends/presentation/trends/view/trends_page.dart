import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../trend_movies/trend_movies.dart';
import '../../trend_series/trend_movies.dart';
import '../constants/trends_view_enum.dart';
import '../cubit/trends_cubit.dart';

class TrendsPage extends StatelessWidget {
  const TrendsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TrendsCubit>(
      create: (context) => TrendsCubit(),
      child: Scaffold(
        appBar: AppBar(title: Text('Movieet Lite'), backgroundColor: Colors.transparent, elevation: 0),
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
