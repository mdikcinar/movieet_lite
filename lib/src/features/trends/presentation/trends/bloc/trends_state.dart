part of 'trends_bloc.dart';

enum TrendsStatus { initial, loading, fetched, failure }

enum TrendsTab { movies, series }

class TrendsState extends Equatable {
  const TrendsState({
    this.trendsTab = TrendsTab.movies,
    this.moviesStatus = TrendsStatus.initial,
    this.seriesStatus = TrendsStatus.initial,
    this.trendMovies = const <Trend>[],
    this.trendSeries = const <Trend>[],
    this.trendMoviesPage = 1,
    this.trendSeriesPage = 1,
    this.isMoviesMaxLimitReached = false,
    this.isSeriesMaxLimitReached = false,
  });
  final TrendsTab trendsTab;
  final TrendsStatus moviesStatus;
  final TrendsStatus seriesStatus;
  final List<Trend> trendMovies;
  final List<Trend> trendSeries;
  final int trendMoviesPage;
  final int trendSeriesPage;
  final bool isMoviesMaxLimitReached;
  final bool isSeriesMaxLimitReached;

  TrendsState copyWith({
    TrendsTab? trendsTab,
    TrendsStatus? moviesStatus,
    TrendsStatus? seriesStatus,
    List<Trend>? trendMovies,
    List<Trend>? trendSeries,
    int? trendMoviesPage,
    int? trendSeriesPage,
    bool? isMoviesMaxLimitReached,
    bool? isSeriesMaxLimitReached,
  }) {
    return TrendsState(
      trendsTab: trendsTab ?? this.trendsTab,
      moviesStatus: moviesStatus ?? this.moviesStatus,
      seriesStatus: seriesStatus ?? this.seriesStatus,
      trendMovies: trendMovies ?? this.trendMovies,
      trendSeries: trendSeries ?? this.trendSeries,
      trendMoviesPage: trendMoviesPage ?? this.trendMoviesPage,
      trendSeriesPage: trendSeriesPage ?? this.trendSeriesPage,
      isMoviesMaxLimitReached: isMoviesMaxLimitReached ?? this.isMoviesMaxLimitReached,
      isSeriesMaxLimitReached: isSeriesMaxLimitReached ?? this.isSeriesMaxLimitReached,
    );
  }

  @override
  List<Object> get props => [
        trendsTab,
        moviesStatus,
        seriesStatus,
        trendMovies,
        trendSeries,
        trendMoviesPage,
        trendSeriesPage,
        isMoviesMaxLimitReached,
        isSeriesMaxLimitReached,
      ];
}
