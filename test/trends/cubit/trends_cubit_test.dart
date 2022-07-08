import 'package:flutter_test/flutter_test.dart';
import 'package:movieetlite/src/features/trends/presentation/trends/cubit/trends_cubit.dart';

void main() {
  late TrendsCubit trendsCubit;

  setUp(() {
    trendsCubit = TrendsCubit();
  });
  group('Trends Cubit', () {
    test('initial state is Trend.movies', () {
      expect(trendsCubit.state, TrendsState.movies);
    });
    test('emit state Trend.series', () {
      trendsCubit.changeTrendsState(TrendsState.serries);
      expect(trendsCubit.state, TrendsState.serries);
    });
  });
}
