part of 'trends_bloc.dart';

abstract class TrendsEvent extends Equatable {
  const TrendsEvent();

  @override
  List<Object> get props => [];
}

class TrendMoviesFetched extends TrendsEvent {}

class TrendSeriesFetched extends TrendsEvent {}

class TrendMoviesTabViewed extends TrendsEvent {}

class TrendSeriesTabViewed extends TrendsEvent {}
