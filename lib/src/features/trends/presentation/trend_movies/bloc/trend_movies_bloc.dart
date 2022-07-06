import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movieetlite/src/features/trends/data/trends_service.dart';
import 'package:movieetlite/src/features/trends/domain/trend.dart';
import 'package:movieetlite/src/utils/constants/enums.dart';
import 'package:movieetlite/src/utils/domain/paginated_data.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:stream_transform/stream_transform.dart';

part 'trend_movies_event.dart';
part 'trend_movies_state.dart';

const throttleDuration = Duration(milliseconds: 500);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class TrendMoviesBloc extends Bloc<TrendMoviesEvent, TrendMoviesState> {
  TrendMoviesBloc(this._trendsService) : super(const TrendMoviesState()) {
    on<TrendMoviesFetched>(
      _onTrendMoviesFetched,
      //transformer: throttleDroppable(throttleDuration),
    );
  }

  final TrendsService _trendsService;

  Future<void> _onTrendMoviesFetched(TrendMoviesFetched event, Emitter<TrendMoviesState> emit) async {
    try {
      if (state.trendMovies.isNotEmpty) emit(state.copyWith(status: TrendMoviesStatus.loading));
      final paginatedData = await _fetchTrendMovies();
      final trendMovies = paginatedData?.results;
      trendMovies == null && trendMovies!.isEmpty
          ? emit(
              state.copyWith(
                isMaxLimitReached: true,
                status: TrendMoviesStatus.fetched,
              ),
            )
          : emit(
              state.copyWith(
                status: TrendMoviesStatus.fetched,
                trendMovies: List.of(state.trendMovies)..addAll(trendMovies),
              ),
            );
    } catch (exception, stackTrace) {
      emit(state.copyWith(status: TrendMoviesStatus.failure));
      await Sentry.captureException(exception, stackTrace: stackTrace);
    }
  }

  Future<PaginatedData<Trend>?> _fetchTrendMovies({int page = 1, String language = 'en', bool isWeek = true}) async {
    final result = await _trendsService.getTrends(
      MediaType.movie,
      TimeWindow.week,
      apiKey: dotenv.env['API-KEY'],
    );
    return result.body;
  }
}
