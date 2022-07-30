import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:movieetlite/src/features/trends/data/repository/base_trends_repository.dart';
import 'package:movieetlite/src/features/trends/domain/trend.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:stream_transform/stream_transform.dart';

part 'trends_event.dart';
part 'trends_state.dart';

const throttleDuration = Duration(milliseconds: 200);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class TrendsBloc extends Bloc<TrendsEvent, TrendsState> {
  TrendsBloc(this._trendsRepository) : super(const TrendsState()) {
    on<TrendMoviesFetched>(
      _onTrendMoviesFetched,
      transformer: throttleDroppable(throttleDuration),
    );
    on<TrendSeriesFetched>(
      _onTrendSeriesFetched,
      transformer: throttleDroppable(throttleDuration),
    );
    on<TrendMoviesTabViewed>(_onTrendMoviesTabViewed);
    on<TrendSeriesTabViewed>(_onTrendSeriesTabViewed);
  }

  final ITrendsRepository _trendsRepository;

  double movieListScrollPosition = 0;
  double seriesListScrollPosition = 0;

  Future<void> _onTrendMoviesTabViewed(TrendMoviesTabViewed event, Emitter<TrendsState> emit) async {
    emit(state.copyWith(trendsTab: TrendsTab.movies));
  }

  Future<void> _onTrendSeriesTabViewed(TrendSeriesTabViewed event, Emitter<TrendsState> emit) async {
    emit(state.copyWith(trendsTab: TrendsTab.series));
  }

  Future<void> _onTrendMoviesFetched(TrendMoviesFetched event, Emitter<TrendsState> emit) async {
    if (state.isMoviesMaxLimitReached) return;
    try {
      if (state.trendMovies.isNotEmpty) emit(state.copyWith(moviesStatus: TrendsStatus.loading));
      final trendMovies = await _trendsRepository.fetchTrendMovies(page: state.trendMoviesPage);
      if (trendMovies == null || trendMovies.isEmpty) {
        emit(
          state.copyWith(
            isMoviesMaxLimitReached: true,
            moviesStatus: TrendsStatus.fetched,
          ),
        );
      } else {
        emit(
          state.copyWith(
            moviesStatus: TrendsStatus.fetched,
            trendMovies: List.of(state.trendMovies)..addAll(trendMovies),
            trendMoviesPage: state.trendMoviesPage + 1,
          ),
        );
      }
    } catch (exception, stackTrace) {
      emit(state.copyWith(moviesStatus: TrendsStatus.failure));
      await Sentry.captureException(exception, stackTrace: stackTrace);
    }
  }

  Future<void> _onTrendSeriesFetched(TrendSeriesFetched event, Emitter<TrendsState> emit) async {
    if (state.isSeriesMaxLimitReached) return;
    try {
      if (state.trendSeries.isNotEmpty) emit(state.copyWith(seriesStatus: TrendsStatus.loading));
      final trendSeries = await _trendsRepository.fetchTrendSeries(page: state.trendSeriesPage);
      if (trendSeries == null || trendSeries.isEmpty) {
        emit(
          state.copyWith(
            isSeriesMaxLimitReached: true,
            seriesStatus: TrendsStatus.fetched,
          ),
        );
      } else {
        emit(
          state.copyWith(
            seriesStatus: TrendsStatus.fetched,
            trendSeries: List.of(state.trendSeries)..addAll(trendSeries),
            trendSeriesPage: state.trendSeriesPage + 1,
          ),
        );
      }
    } catch (exception, stackTrace) {
      emit(state.copyWith(seriesStatus: TrendsStatus.failure));
      await Sentry.captureException(exception, stackTrace: stackTrace);
    }
  }
}
