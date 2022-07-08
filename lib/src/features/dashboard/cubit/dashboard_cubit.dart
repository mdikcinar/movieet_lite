import 'package:flutter_bloc/flutter_bloc.dart';

enum DashboardView { trends, search, profile }

class DashboardCubit extends Cubit<DashboardView> {
  DashboardCubit() : super(DashboardView.trends);

  void changeDashboardView(DashboardView value) => emit(value);
}
