part of 'trend_movies_bloc.dart';

abstract class TrendMoviesEvent extends Equatable {
  const TrendMoviesEvent();

  @override
  List<Object> get props => [];
}

class TrendMoviesFetched extends TrendMoviesEvent {}
