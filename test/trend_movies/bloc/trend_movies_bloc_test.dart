import 'package:bloc_test/bloc_test.dart';
import 'package:chopper/chopper.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movieetlite/src/core/network/chopper_client.dart';
import 'package:movieetlite/src/features/trends/data/trends_service.dart';
import 'package:movieetlite/src/features/trends/domain/trend.dart';
import 'package:movieetlite/src/features/trends/presentation/trend_movies/bloc/trend_movies_bloc.dart';
import 'package:movieetlite/src/utils/constants/enums.dart';

class MockTrendsService extends Mock implements TrendsService {}

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  late TrendsService trendsService;
  late ChopperClient chopperClient;

  setUp(() {
    trendsService = MockTrendsService();
  });

  setUpAll(() {
    registerFallbackValue(MediaType.movie);
    registerFallbackValue(TimeWindow.week);
  });

  group('Trend Movies Bloc', () {
    test('initial state is TrendMoviesState', () {
      expect(TrendMoviesBloc(trendsService).state, const TrendMoviesState());
    });
    blocTest<TrendMoviesBloc, TrendMoviesState>(
      'emits failure when get exception',
      setUp: () {
        when(() => trendsService.getTrends(any(), any(), apiKey: '')).thenThrow(Exception());
      },
      build: () => TrendMoviesBloc(trendsService),
      act: (bloc) => bloc.add(TrendMoviesFetched()),
      seed: () => const TrendMoviesState(),
      expect: () => <TrendMoviesState>[
        const TrendMoviesState(status: TrendMovieStatus.failure),
      ],
    );

    blocTest<TrendMoviesBloc, TrendMoviesState>(
      'emits nothing when reached maximum limit',
      build: () => TrendMoviesBloc(trendsService),
      seed: () => const TrendMoviesState(isMaxLimitReached: true),
      act: (bloc) => bloc.add(TrendMoviesFetched()),
      expect: () => <TrendMoviesState>[],
    );
    blocTest<TrendMoviesBloc, TrendMoviesState>(
      'emits loading when fetching additional data',
      build: () => TrendMoviesBloc(trendsService),
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
        final httpClient = MockClient((request) async {
          return http.Response(
            '''
            {
              "page": 1,
              "results": [],
              "total_pages": 1000,
              "total_results": 20000
              }
            ''',
            200,
          );
        });
        chopperClient = ChopperClientBuilder.buildChopperClient(
          [
            TrendsService.create(),
          ],
          baseUrl: '',
          httpClient: httpClient,
        );
      },
      build: () => TrendMoviesBloc(TrendsService.create(chopperClient)),
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
        final httpClient = MockClient((request) async {
          return http.Response(
            '''
            {
              "page": 1,
              "results": [
                {
                  "media_type": "movie"
                }
              ],
              "total_pages": 1000,
              "total_results": 20000
              }
            ''',
            200,
          );
        });
        chopperClient = ChopperClientBuilder.buildChopperClient(
          [
            TrendsService.create(),
          ],
          baseUrl: '',
          httpClient: httpClient,
        );
      },
      build: () => TrendMoviesBloc(TrendsService.create(chopperClient)),
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
