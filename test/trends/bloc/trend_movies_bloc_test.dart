import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movieetlite/src/features/trends/data/repository/base_trends_repository.dart';
import 'package:movieetlite/src/features/trends/domain/trend.dart';
import 'package:movieetlite/src/features/trends/presentation/trends/bloc/trends_bloc.dart';
import 'package:movieetlite/src/utils/constants/enums.dart';

class MockITrendsRepository extends Mock implements ITrendsRepository {}

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  late ITrendsRepository trendsRepository;

  setUp(() {
    trendsRepository = MockITrendsRepository();
  });

  setUpAll(() {
    registerFallbackValue(MediaType.movie);
    registerFallbackValue(TimeWindow.week);
  });

  group('Trend Movies Bloc', () {
    test('initial state is TrendsState', () {
      expect(TrendsBloc(trendsRepository).state, const TrendsState());
    });
    blocTest<TrendsBloc, TrendsState>(
      'emits Trends movies tab viewed',
      build: () => TrendsBloc(trendsRepository),
      act: (bloc) => bloc.add(TrendMoviesTabViewed()),
      seed: () => const TrendsState(trendsTab: TrendsTab.series),
      expect: () => <TrendsState>[
        const TrendsState(),
      ],
    );
    blocTest<TrendsBloc, TrendsState>(
      'emits Trends series tab viewed',
      build: () => TrendsBloc(trendsRepository),
      act: (bloc) => bloc.add(TrendSeriesTabViewed()),
      seed: () => const TrendsState(),
      expect: () => <TrendsState>[
        const TrendsState(trendsTab: TrendsTab.series),
      ],
    );
    blocTest<TrendsBloc, TrendsState>(
      'emits failure when get exception while fetch movies',
      setUp: () {
        when(() => trendsRepository.fetchTrendMovies(page: 1)).thenThrow(Exception());
      },
      build: () => TrendsBloc(trendsRepository),
      act: (bloc) => bloc.add(TrendMoviesFetched()),
      seed: () => const TrendsState(),
      expect: () => <TrendsState>[
        const TrendsState(moviesStatus: TrendsStatus.failure),
      ],
    );
    blocTest<TrendsBloc, TrendsState>(
      'emits failure when get exception while fetch series',
      setUp: () {
        when(() => trendsRepository.fetchTrendSeries(page: 1)).thenThrow(Exception());
      },
      build: () => TrendsBloc(trendsRepository),
      act: (bloc) => bloc.add(TrendSeriesFetched()),
      seed: () => const TrendsState(),
      expect: () => <TrendsState>[
        const TrendsState(seriesStatus: TrendsStatus.failure),
      ],
    );

    blocTest<TrendsBloc, TrendsState>(
      'emits nothing when reached maximum limit on fetch movies',
      build: () => TrendsBloc(trendsRepository),
      seed: () => const TrendsState(isMoviesMaxLimitReached: true),
      act: (bloc) => bloc.add(TrendMoviesFetched()),
      expect: () => <TrendsState>[],
    );
    blocTest<TrendsBloc, TrendsState>(
      'emits nothing when reached maximum limit on fetch series',
      build: () => TrendsBloc(trendsRepository),
      seed: () => const TrendsState(isSeriesMaxLimitReached: true),
      act: (bloc) => bloc.add(TrendSeriesFetched()),
      expect: () => <TrendsState>[],
    );
    blocTest<TrendsBloc, TrendsState>(
      'emits loading while fetching additional movies data',
      setUp: () {
        when(() => trendsRepository.fetchTrendMovies(page: 2))
            .thenAnswer((_) => Future.value(const [Trend(mediaType: 'movie')]));
      },
      build: () => TrendsBloc(trendsRepository),
      seed: () => const TrendsState(
        trendMovies: [Trend()],
        trendMoviesPage: 2,
      ),
      act: (bloc) => bloc.add(TrendMoviesFetched()),
      expect: () => <TrendsState>[
        const TrendsState(
          moviesStatus: TrendsStatus.loading,
          trendMovies: [Trend()],
          trendMoviesPage: 2,
        ),
        const TrendsState(
          moviesStatus: TrendsStatus.fetched,
          trendMovies: [Trend(), Trend(mediaType: 'movie')],
          trendMoviesPage: 3,
        ),
      ],
    );
    blocTest<TrendsBloc, TrendsState>(
      'emits loading while fetching additional series data',
      setUp: () {
        when(() => trendsRepository.fetchTrendSeries(page: 2))
            .thenAnswer((_) => Future.value(const [Trend(mediaType: 'series')]));
      },
      build: () => TrendsBloc(trendsRepository),
      seed: () => const TrendsState(
        trendSeries: [Trend()],
        trendSeriesPage: 2,
      ),
      act: (bloc) => bloc.add(TrendSeriesFetched()),
      expect: () => <TrendsState>[
        const TrendsState(
          seriesStatus: TrendsStatus.loading,
          trendSeries: [Trend()],
          trendSeriesPage: 2,
        ),
        const TrendsState(
          seriesStatus: TrendsStatus.fetched,
          trendSeries: [Trend(), Trend(mediaType: 'series')],
          trendSeriesPage: 3,
        ),
      ],
    );

    blocTest<TrendsBloc, TrendsState>(
      'emits max limit reached when fetch empty movies',
      setUp: () async {
        when(() => trendsRepository.fetchTrendMovies(page: 1)).thenAnswer((_) => Future.value(<Trend>[]));
      },
      build: () => TrendsBloc(trendsRepository),
      act: (bloc) => bloc.add(TrendMoviesFetched()),
      expect: () => <TrendsState>[
        const TrendsState(
          isMoviesMaxLimitReached: true,
          moviesStatus: TrendsStatus.fetched,
        ),
      ],
    );
    blocTest<TrendsBloc, TrendsState>(
      'emits max limit reached when fetch empty series',
      setUp: () async {
        when(() => trendsRepository.fetchTrendSeries(page: 1)).thenAnswer((_) => Future.value(<Trend>[]));
      },
      build: () => TrendsBloc(trendsRepository),
      act: (bloc) => bloc.add(TrendSeriesFetched()),
      expect: () => <TrendsState>[
        const TrendsState(
          isSeriesMaxLimitReached: true,
          seriesStatus: TrendsStatus.fetched,
        ),
      ],
    );
    blocTest<TrendsBloc, TrendsState>(
      'emits movies data fetched and increases page number',
      setUp: () async {
        when(() => trendsRepository.fetchTrendMovies(page: 1))
            .thenAnswer((_) => Future.value(const [Trend(mediaType: 'movie')]));
      },
      build: () => TrendsBloc(trendsRepository),
      act: (bloc) => bloc.add(TrendMoviesFetched()),
      expect: () => <TrendsState>[
        const TrendsState(
          moviesStatus: TrendsStatus.fetched,
          trendMovies: [Trend(mediaType: 'movie')],
          trendMoviesPage: 2,
        ),
      ],
    );
    blocTest<TrendsBloc, TrendsState>(
      'emits series data fetched and increases page number',
      setUp: () async {
        when(() => trendsRepository.fetchTrendSeries(page: 1))
            .thenAnswer((_) => Future.value(const [Trend(mediaType: 'series')]));
      },
      build: () => TrendsBloc(trendsRepository),
      act: (bloc) => bloc.add(TrendSeriesFetched()),
      expect: () => <TrendsState>[
        const TrendsState(
          seriesStatus: TrendsStatus.fetched,
          trendSeries: [Trend(mediaType: 'series')],
          trendSeriesPage: 2,
        ),
      ],
    );
  });
}
