import 'package:flutter/material.dart';

import '../../../dashboard/dashboard.dart';
import '../../../details/view/details_page.dart';
import '../../base/view/route_not_found_page.dart';
import 'app_routes.dart';

class NavigationRoute {
  static final NavigationRoute _instance = NavigationRoute._init();
  static NavigationRoute get instance => _instance;

  NavigationRoute._init();

  MaterialPageRoute<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.dashboard:
        return normalNavigate(const DashboardPage(), settings);
      case AppRoutes.details:
        return normalNavigate(const DetailsPage(), settings);
      default:
        return MaterialPageRoute(
          builder: (context) => RouteNotFoundPage(routeName: settings.name),
        );
    }
  }

  MaterialPageRoute normalNavigate(Widget page, RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => page,
      settings: settings,
    );
  }
}
