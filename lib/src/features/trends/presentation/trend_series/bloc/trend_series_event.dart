part of 'trend_series_bloc.dart';

abstract class TrendSeriesEvent extends Equatable {
  const TrendSeriesEvent();

  @override
  List<Object> get props => [];
}

class TrendSeriesFetched extends TrendSeriesEvent {}
