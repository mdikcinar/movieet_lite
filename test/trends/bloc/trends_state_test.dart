// ignore_for_file: avoid_redundant_argument_values

import 'package:flutter_test/flutter_test.dart';
import 'package:movieetlite/src/features/trends/presentation/trends/bloc/trends_bloc.dart';

void main() {
  group('Trend movies state test', () {
    test('has correct initial state', () {
      const state = TrendsState();
      expect(
        state,
        const TrendsState(
          trendMoviesPage: 1,
          trendSeriesPage: 1,
          moviesStatus: TrendsStatus.initial,
          seriesStatus: TrendsStatus.initial,
          trendMovies: [],
          trendSeries: [],
          isMoviesMaxLimitReached: false,
          isSeriesMaxLimitReached: false,
          trendsTab: TrendsTab.movies,
        ),
      );
    });
  });
}
