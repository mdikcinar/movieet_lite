import 'package:bloc/bloc.dart';

import '../constants/trends_view_enum.dart';

class TrendsCubit extends Cubit<TrendsView> {
  TrendsCubit() : super(TrendsView.movies);

  void changeTrendsView(TrendsView value) => emit(value);
}
