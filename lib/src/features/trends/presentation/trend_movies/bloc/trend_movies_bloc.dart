import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:movieetlite/src/features/trends/data/repository/base_trends_repository.dart';
import 'package:movieetlite/src/features/trends/domain/trend.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:stream_transform/stream_transform.dart';

part 'trend_movies_event.dart';
part 'trend_movies_state.dart';

const throttleDuration = Duration(milliseconds: 200);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class TrendMoviesBloc extends Bloc<TrendMoviesEvent, TrendMoviesState> {
  TrendMoviesBloc(this._trendsRepository) : super(const TrendMoviesState()) {
    on<TrendMoviesFetched>(
      _onTrendMoviesFetched,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  final ITrendsRepository _trendsRepository;
  int _page = 1;

  Future<void> _onTrendMoviesFetched(TrendMoviesFetched event, Emitter<TrendMoviesState> emit) async {
    if (state.isMaxLimitReached) return;
    try {
      if (state.trendMovies.isNotEmpty) emit(state.copyWith(status: TrendMovieStatus.loading));
      final trendMovies = await _trendsRepository.fetchTrendMovies(page: _page);
      if (trendMovies == null || trendMovies.isEmpty) {
        emit(
          state.copyWith(
            isMaxLimitReached: true,
            status: TrendMovieStatus.fetched,
          ),
        );
      } else {
        _page++;
        emit(
          state.copyWith(
            status: TrendMovieStatus.fetched,
            trendMovies: List.of(state.trendMovies)..addAll(trendMovies),
            page: _page,
          ),
        );
      }
    } catch (exception, stackTrace) {
      emit(state.copyWith(status: TrendMovieStatus.failure));
      await Sentry.captureException(exception, stackTrace: stackTrace);
    }
  }
}
