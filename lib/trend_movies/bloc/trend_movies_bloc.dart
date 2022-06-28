import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:stream_transform/stream_transform.dart';

import '../../0-core/init/network/base_core_dio.dart';
import '../../0-core/init/network/request_type_enum.dart';
import '../../1-common/model/paginated_data.dart';
import '../model/trend_movie.dart';

part 'trend_movies_event.dart';
part 'trend_movies_state.dart';

const throttleDuration = Duration(milliseconds: 500);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class TrendMoviesBloc extends Bloc<TrendMoviesEvent, TrendMoviesState> {
  late ICoreDio _coreDio;

  TrendMoviesBloc({required ICoreDio coreDio}) : super(const TrendMoviesState()) {
    _coreDio = coreDio;
    on<TrendMoviesFetched>(
      _onTrendMoviesFetched,
      //transformer: throttleDroppable(throttleDuration),
    );
  }

  Future<void> _onTrendMoviesFetched(TrendMoviesFetched event, Emitter<TrendMoviesState> emit) async {
    try {
      if (state.status == TrendMoviesStatus.initial) {
        var paginatedData = await _fetchTrendMovies();
        paginatedData?.results = (paginatedData.results as List).map((e) => TrendMovie.fromJson(e)).toList();
        return emit(state.copyWith(
          status: TrendMoviesStatus.success,
          trendMovies: paginatedData?.results,
          page: paginatedData?.page,
        ));
      }
      var paginatedData = await _fetchTrendMovies();
      paginatedData?.results = (paginatedData.results as List).map((e) => TrendMovie.fromJson(e)).toList();
      paginatedData?.results.isEmpty
          ? emit(state.copyWith())
          : emit(
              state.copyWith(
                status: TrendMoviesStatus.success,
                trendMovies: List.of(state.trendMovies)..addAll(paginatedData?.results),
                page: paginatedData?.page,
              ),
            );
    } catch (exception, stackTrace) {
      emit(state.copyWith(status: TrendMoviesStatus.failure));
      await Sentry.captureException(exception, stackTrace: stackTrace);
    }
  }

  Future<PaginatedData?> _fetchTrendMovies({int page = 1, String language = 'en', bool isWeek = true}) async {
    var timeWindow = isWeek ? 'week' : 'day';
    final path = 'trending/movie/$timeWindow?api_key=${dotenv.env['API-KEY']}&page=$page&language=$language';
    final result = await _coreDio.send<PaginatedData, PaginatedData>(
      path,
      parseModel: PaginatedData(),
      requestType: RequestType.GET,
    );
    if (result.data is! PaginatedData) return null;
    return result.data;
  }
}
