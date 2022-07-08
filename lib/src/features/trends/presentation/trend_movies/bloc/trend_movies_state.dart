part of 'trend_movies_bloc.dart';

enum TrendMovieStatus { initial, loading, fetched, failure }

class TrendMoviesState extends Equatable {
  const TrendMoviesState({
    this.status = TrendMovieStatus.initial,
    this.trendMovies = const <Trend>[],
    this.page = 1,
    this.isMaxLimitReached = false,
  });
  final TrendMovieStatus status;
  final List<Trend> trendMovies;
  final int page;
  final bool isMaxLimitReached;

  TrendMoviesState copyWith({
    TrendMovieStatus? status,
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
