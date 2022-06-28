part of 'trend_movies_bloc.dart';

enum TrendMoviesStatus { initial, success, failure }

class TrendMoviesState extends Equatable {
  final TrendMoviesStatus status;
  final List<TrendMovie> trendMovies;
  final int page;

  const TrendMoviesState({
    this.status = TrendMoviesStatus.initial,
    this.trendMovies = const <TrendMovie>[],
    this.page = 1,
  });

  TrendMoviesState copyWith({
    TrendMoviesStatus? status,
    List<TrendMovie>? trendMovies,
    int? page,
  }) {
    return TrendMoviesState(
      status: status ?? this.status,
      trendMovies: trendMovies ?? this.trendMovies,
      page: page ?? this.page,
    );
  }

  @override
  List<Object> get props => [status, trendMovies, page];
}
