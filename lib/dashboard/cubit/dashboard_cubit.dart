import 'package:flutter_bloc/flutter_bloc.dart';

import '../constants/dashboard_view_enum.dart';

class DashboardCubit extends Cubit<DashboardView> {
  DashboardCubit() : super(DashboardView.trends);

  void changeDashboardView(DashboardView value) => emit(value);
}
