import 'dart:convert';

import 'package:bloc_test/bloc_test.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movieetlite/0-core/constants/app_constants.dart';
import 'package:movieetlite/0-core/init/network/core_dio.dart';
import 'package:movieetlite/0-core/init/network/network_manager.dart';
import 'package:movieetlite/0-core/init/network/request_type_enum.dart';
import 'package:movieetlite/1-common/model/paginated_data.dart';
import 'package:movieetlite/trend_movies/bloc/trend_movies_bloc.dart';
import 'package:movieetlite/trend_movies/model/trend_movie.dart';

class DioAdapterMock extends Mock implements HttpClientAdapter {}

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  group('Trend Movies Bloc', () {
    late CoreDio coreDio;
    late DioAdapterMock dioAdapterMock;

    const mockTrendMovies = [TrendMovie(id: 1, title: 'Test', overview: 'description')];
    const extraMockTrendMovies = [TrendMovie(id: 2, title: 'Test2', overview: 'description2')];

    setUpAll(() {
      registerFallbackValue(RequestOptions(path: ''));
    });

    setUp(() {
      dioAdapterMock = DioAdapterMock();
      coreDio = NetworkManager.instance.coreDio;
      coreDio.httpClientAdapter = dioAdapterMock;
    });

    test('initial state is TrendMoviesInitial()', () {
      expect(TrendMoviesBloc(coreDio: coreDio).state, const TrendMoviesState());
    });

    group('Movies Fetched', () {
      blocTest<TrendMoviesBloc, TrendMoviesState>(
        'emits successful status when dio fetches initial movies',
        setUp: () {
          when(() => dioAdapterMock.fetch(any(), any(), any())).thenAnswer((_) async {
            final json = PaginatedData(results: mockTrendMovies.map((e) => e.toJson()).toList()).toJson();
            final responsePayload = jsonEncode(json);
            return ResponseBody.fromString(
              responsePayload,
              200,
              headers: {
                Headers.contentTypeHeader: [Headers.jsonContentType],
              },
            );
          });
        },
        build: () => TrendMoviesBloc(coreDio: coreDio),
        act: (bloc) => bloc.add(TrendMoviesFetched()),
        wait: const Duration(milliseconds: 100),
        expect: () => const <TrendMoviesState>[
          TrendMoviesState(
            status: TrendMoviesStatus.success,
            trendMovies: mockTrendMovies,
            page: 1,
          )
        ],
        /*verify: (_) => verify(() {
          final path = 'trending/movie/week?api_key=${dotenv.env['API-KEY']}&page=1&language=en';
          return coreDio.send<PaginatedData, PaginatedData>(path,
              requestType: RequestType.GET, parseModel: PaginatedData());
        }).called(1),*/
      );
    });
  });
}
