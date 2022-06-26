part of 'trend_movies_bloc.dart';

abstract class TrendMoviesState extends Equatable {
  const TrendMoviesState();
  
  @override
  List<Object> get props => [];
}

class TrendMoviesInitial extends TrendMoviesState {}
