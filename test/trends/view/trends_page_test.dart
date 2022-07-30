import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movieetlite/src/core/widgets/other/centered_progress_indicator.dart';
import 'package:movieetlite/src/features/trends/domain/trend.dart';
import 'package:movieetlite/src/features/trends/presentation/trends/bloc/trends_bloc.dart';
import 'package:movieetlite/src/features/trends/presentation/trends/trends.dart';

import '../../utils.dart';

class MockTrendsBloc extends MockBloc<TrendsEvent, TrendsState> implements TrendsBloc {}

void main() {
  late TrendsBloc trendsBloc;

  setUp(() {
    trendsBloc = MockTrendsBloc();
  });

  group('Trends Page', () {
    testWidgets(
      'TrendMoviesFetched called on init',
      (WidgetTester tester) async {
        when(() => trendsBloc.state).thenReturn(const TrendsState());
        await tester.pumpMaterialWidget<TrendsBloc>(TrendsPage(trendsBloc));
        verify(() => trendsBloc.add(TrendMoviesFetched())).called(1);
      },
    );
    testWidgets(
      'Renders movies & series tab buttons and centered circular indicator on initial state',
      (WidgetTester tester) async {
        when(() => trendsBloc.state).thenReturn(const TrendsState());
        await tester.pumpMaterialWidget<TrendsBloc>(TrendsPage(trendsBloc));
        final moviesTabButtonFinder = find.byKey(const Key('movies-tab-button'));
        final seriesTabButtonFinder = find.byKey(const Key('series-tab-button'));
        expect(moviesTabButtonFinder, findsOneWidget);
        expect(seriesTabButtonFinder, findsOneWidget);
        expect(find.byType(CenteredProgressIndicator), findsOneWidget);
      },
    );

    testWidgets(
      'TrendSeriesFetched called on tab series tab, circular indicator rendered',
      (WidgetTester tester) async {
        when(() => trendsBloc.state).thenReturn(const TrendsState());
        await tester.pumpMaterialWidget(TrendsPage(trendsBloc));
        final seriesTabButtonFinder = find.byKey(const Key('series-tab-button'));
        await tester.tap(seriesTabButtonFinder);
        verify(() => trendsBloc.add(TrendSeriesTabViewed())).called(1);
        verify(() => trendsBloc.add(TrendSeriesFetched())).called(1);
        await tester.pump();
        expect(find.byType(CenteredProgressIndicator), findsOneWidget);
      },
    );

    testWidgets(
      'TrendMoviesTab called when on tap movies',
      (WidgetTester tester) async {
        when(() => trendsBloc.state).thenReturn(
          const TrendsState(
            trendsTab: TrendsTab.series,
          ),
        );
        await tester.pumpMaterialWidget(TrendsPage(trendsBloc));
        final moviesTabButtonFinder = find.byKey(const Key('movies-tab-button'));
        await tester.pump();
        await tester.tap(moviesTabButtonFinder);
        verify(() => trendsBloc.add(TrendMoviesTabViewed())).called(1);
      },
    );
  });

  group('Trend Tab', () {
    testWidgets(
      'Renders movie list',
      (WidgetTester tester) async {
        when(() => trendsBloc.movieListScrollPosition).thenReturn(0);
        when(() => trendsBloc.state).thenReturn(
          const TrendsState(
            trendMovies: [Trend()],
            moviesStatus: TrendsStatus.fetched,
          ),
        );
        await tester.pumpMaterialWidget<TrendsBloc>(const TrendTab(), bloc: trendsBloc);
        final movieListFinder = find.byKey(const Key('trend-movie-list'));
        await tester.pumpAndSettle();
        expect(movieListFinder, findsOneWidget);
      },
    );

    testWidgets(
      'Renders series list',
      (WidgetTester tester) async {
        when(() => trendsBloc.seriesListScrollPosition).thenReturn(0);
        when(() => trendsBloc.state).thenReturn(
          const TrendsState(
            trendsTab: TrendsTab.series,
            trendSeries: [Trend()],
            seriesStatus: TrendsStatus.fetched,
          ),
        );
        await tester.pumpMaterialWidget<TrendsBloc>(const TrendTab(), bloc: trendsBloc);
        final seriesListFinder = find.byKey(const Key('trend-series-list'));
        await tester.pumpAndSettle();
        expect(seriesListFinder, findsOneWidget);
      },
    );

    testWidgets(
      'Fetches new trend movies when scrolls to bottom',
      (WidgetTester tester) async {
        when(() => trendsBloc.movieListScrollPosition).thenReturn(0);
        when(() => trendsBloc.state).thenReturn(
          TrendsState(
            trendMovies: List.generate(20, (index) => Trend(id: index)),
            moviesStatus: TrendsStatus.fetched,
          ),
        );
        await tester.pumpMaterialWidget<TrendsBloc>(const TrendTab(), bloc: trendsBloc);
        await tester.pumpAndSettle();
        await tester.drag(find.byType(GridView), const Offset(0, -2500));
        verify(() => trendsBloc.add(TrendMoviesFetched())).called(1);
      },
    );
    testWidgets(
      'Fetches new trend series when scrolls to bottom',
      (WidgetTester tester) async {
        when(() => trendsBloc.seriesListScrollPosition).thenReturn(0);
        when(() => trendsBloc.state).thenReturn(
          TrendsState(
            trendsTab: TrendsTab.series,
            trendSeries: List.generate(20, (index) => Trend(id: index)),
            seriesStatus: TrendsStatus.fetched,
          ),
        );
        await tester.pumpMaterialWidget<TrendsBloc>(const TrendTab(), bloc: trendsBloc);
        await tester.pumpAndSettle();
        await tester.drag(find.byType(GridView), const Offset(0, -2500));
        verify(() => trendsBloc.add(TrendSeriesFetched())).called(1);
      },
    );

    testWidgets(
      'Renders bottom loader while Fetching new trend movies',
      (WidgetTester tester) async {
        when(() => trendsBloc.movieListScrollPosition).thenReturn(0);
        when(() => trendsBloc.state).thenReturn(
          const TrendsState(
            trendMovies: [Trend()],
            moviesStatus: TrendsStatus.loading,
          ),
        );
        await tester.pumpMaterialWidget<TrendsBloc>(const TrendTab(), bloc: trendsBloc);
        final bottomLoaderFinder = find.byKey(const Key('bottom-loader'));
        expect(bottomLoaderFinder, findsOneWidget);
      },
    );
    testWidgets(
      'Renders bottom loader while Fetching new trend series',
      (WidgetTester tester) async {
        when(() => trendsBloc.seriesListScrollPosition).thenReturn(0);
        when(() => trendsBloc.state).thenReturn(
          const TrendsState(
            trendsTab: TrendsTab.series,
            trendSeries: [Trend()],
            seriesStatus: TrendsStatus.loading,
          ),
        );
        await tester.pumpMaterialWidget<TrendsBloc>(const TrendTab(), bloc: trendsBloc);
        final bottomLoaderFinder = find.byKey(const Key('bottom-loader'));
        expect(bottomLoaderFinder, findsOneWidget);
      },
    );
  });
}
