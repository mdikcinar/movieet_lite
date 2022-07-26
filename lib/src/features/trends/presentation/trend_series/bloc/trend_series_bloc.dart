import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:movieetlite/src/features/trends/data/repository/base_trends_repository.dart';
import 'package:movieetlite/src/features/trends/domain/trend.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:stream_transform/stream_transform.dart';

part 'trend_series_event.dart';
part 'trend_series_state.dart';

const throttleDuration = Duration(milliseconds: 200);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class TrendSeriesBloc extends Bloc<TrendSeriesEvent, TrendSeriesState> {
  TrendSeriesBloc(this._trendsRepository) : super(const TrendSeriesState()) {
    on<TrendSeriesFetched>(
      _onTrendSeriesFetched,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  final ITrendsRepository _trendsRepository;
  int _page = 1;

  Future<void> _onTrendSeriesFetched(TrendSeriesFetched event, Emitter<TrendSeriesState> emit) async {
    if (state.isMaxLimitReached) return;
    try {
      if (state.trendSeries.isNotEmpty) emit(state.copyWith(status: TrendSeriesStatus.loading));
      final trendSeries = await _trendsRepository.fetchTrendSeries(page: _page);
      if (trendSeries == null || trendSeries.isEmpty) {
        emit(
          state.copyWith(
            isMaxLimitReached: true,
            status: TrendSeriesStatus.fetched,
          ),
        );
      } else {
        _page++;
        emit(
          state.copyWith(
            status: TrendSeriesStatus.fetched,
            trendSeries: List.of(state.trendSeries)..addAll(trendSeries),
            page: _page,
          ),
        );
      }
    } catch (exception, stackTrace) {
      emit(state.copyWith(status: TrendSeriesStatus.failure));
      await Sentry.captureException(exception, stackTrace: stackTrace);
    }
  }
}
