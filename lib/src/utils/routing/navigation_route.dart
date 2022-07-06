import 'package:flutter/material.dart';
import 'package:movieetlite/src/core/base/view/route_not_found_page.dart';
import 'package:movieetlite/src/details/view/details_page.dart';
import 'package:movieetlite/src/features/dashboard/dashboard.dart';
import 'package:movieetlite/src/utils/routing/app_routes.dart';

class NavigationRoute {
  NavigationRoute._init();
  static final NavigationRoute _instance = NavigationRoute._init();
  static NavigationRoute get instance => _instance;

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

  MaterialPageRoute<dynamic> normalNavigate(Widget page, RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => page,
      settings: settings,
    );
  }
}
