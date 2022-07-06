part of 'trend_movies_bloc.dart';

enum TrendMoviesStatus { initial, loading, fetched, failure }

class TrendMoviesState extends Equatable {
  const TrendMoviesState({
    this.status = TrendMoviesStatus.initial,
    this.trendMovies = const <Trend>[],
    this.page = 1,
    this.isMaxLimitReached = false,
  });
  final TrendMoviesStatus status;
  final List<Trend> trendMovies;
  final int page;
  final bool isMaxLimitReached;

  TrendMoviesState copyWith({
    TrendMoviesStatus? status,
    List<Trend>? trendMovies,
    int? page,
    bool? isMaxLimitReached,
  }) {
    return TrendMoviesState(
      status: status ?? this.status,
      trendMovies: trendMovies ?? this.trendMovies,
      page: page ?? this.page,
      isMaxLimitReached: isMaxLimitReached ?? this.isMaxLimitReached,
    );
  }

  @override
  List<Object> get props => [status, trendMovies, page, isMaxLimitReached];
}
