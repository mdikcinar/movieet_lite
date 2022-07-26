import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movieetlite/src/features/trends/data/repository/base_trends_repository.dart';
import 'package:movieetlite/src/features/trends/domain/trend.dart';
import 'package:movieetlite/src/features/trends/presentation/trend_movies/bloc/trend_movies_bloc.dart';
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
    test('initial state is TrendMoviesState', () {
      expect(TrendMoviesBloc(trendsRepository).state, const TrendMoviesState());
    });
    blocTest<TrendMoviesBloc, TrendMoviesState>(
      'emits failure when get exception',
      setUp: () {
        when(() => trendsRepository.fetchTrendMovies(page: 1)).thenThrow(Exception());
      },
      build: () => TrendMoviesBloc(trendsRepository),
      act: (bloc) => bloc.add(TrendMoviesFetched()),
      seed: () => const TrendMoviesState(),
      expect: () => <TrendMoviesState>[
        const TrendMoviesState(status: TrendMovieStatus.failure),
      ],
    );

    blocTest<TrendMoviesBloc, TrendMoviesState>(
      'emits nothing when reached maximum limit',
      build: () => TrendMoviesBloc(trendsRepository),
      seed: () => const TrendMoviesState(isMaxLimitReached: true),
      act: (bloc) => bloc.add(TrendMoviesFetched()),
      expect: () => <TrendMoviesState>[],
    );
    blocTest<TrendMoviesBloc, TrendMoviesState>(
      'emits loading when fetching additional data',
      build: () => TrendMoviesBloc(trendsRepository),
      seed: () => const TrendMoviesState(trendMovies: [Trend()]),
      act: (bloc) => bloc.add(TrendMoviesFetched()),
      expect: () => <TrendMoviesState>[
        const TrendMoviesState(status: TrendMovieStatus.loading, trendMovies: [Trend()]),
        const TrendMoviesState(status: TrendMovieStatus.failure, trendMovies: [Trend()]),
      ],
    );

    blocTest<TrendMoviesBloc, TrendMoviesState>(
      'emits max limit reached when gets empty data',
      setUp: () async {
        when(() => trendsRepository.fetchTrendMovies(page: 1)).thenAnswer((_) => Future.value(<Trend>[]));
      },
      build: () => TrendMoviesBloc(trendsRepository),
      act: (bloc) => bloc.add(TrendMoviesFetched()),
      expect: () => <TrendMoviesState>[
        const TrendMoviesState(
          isMaxLimitReached: true,
          status: TrendMovieStatus.fetched,
        ),
      ],
    );
    blocTest<TrendMoviesBloc, TrendMoviesState>(
      'emits data fetched and increases page number',
      setUp: () async {
        when(() => trendsRepository.fetchTrendMovies(page: 1))
            .thenAnswer((_) => Future.value(const [Trend(mediaType: 'movie')]));
      },
      build: () => TrendMoviesBloc(trendsRepository),
      act: (bloc) => bloc.add(TrendMoviesFetched()),
      expect: () => <TrendMoviesState>[
        const TrendMoviesState(
          status: TrendMovieStatus.fetched,
          trendMovies: [Trend(mediaType: 'movie')],
          page: 2,
        ),
      ],
    );
  });
}
