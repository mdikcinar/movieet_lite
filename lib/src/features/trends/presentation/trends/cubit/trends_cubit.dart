import 'package:bloc/bloc.dart';
import 'package:movieetlite/src/features/trends/presentation/trends/trends.dart';

class TrendsCubit extends Cubit<TrendsView> {
  TrendsCubit() : super(TrendsView.movies);

  void changeTrendsView(TrendsView value) => emit(value);
}
