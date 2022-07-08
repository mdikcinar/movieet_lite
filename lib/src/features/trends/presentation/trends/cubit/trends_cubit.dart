import 'package:bloc/bloc.dart';

enum TrendsState { movies, serries }

class TrendsCubit extends Cubit<TrendsState> {
  TrendsCubit() : super(TrendsState.movies);

  void changeTrendsState(TrendsState value) => emit(value);
}
