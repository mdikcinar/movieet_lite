part of 'trend_series_bloc.dart';

enum TrendSeriesStatus { initial, loading, fetched, failure }

class TrendSeriesState extends Equatable {
  const TrendSeriesState({
    this.status = TrendSeriesStatus.initial,
    this.trendSeries = const <Trend>[],
    this.page = 1,
    this.isMaxLimitReached = false,
  });
  final TrendSeriesStatus status;
  final List<Trend> trendSeries;
  final int page;
  final bool isMaxLimitReached;

  TrendSeriesState copyWith({
    TrendSeriesStatus? status,
    List<Trend>? trendSeries,
    int? page,
    bool? isMaxLimitReached,
  }) {
    return TrendSeriesState(
      status: status ?? this.status,
      trendSeries: trendSeries ?? this.trendSeries,
      page: page ?? this.page,
      isMaxLimitReached: isMaxLimitReached ?? this.isMaxLimitReached,
    );
  }

  @override
  List<Object> get props => [status, trendSeries, page, isMaxLimitReached];
}
