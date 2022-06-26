import 'package:flutter/material.dart';

import 'base_navigation_service.dart';

class NavigationService implements BaseNavigationService {
  static final NavigationService _instance = NavigationService._init();
  static NavigationService get instance => _instance;

  NavigationService._init();

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  bool Function(Route route) get removeAllOldRoutes => (Route<dynamic> route) => false;

  @override
  Future<void> toNamed(String path, {Object? arguments}) async {
    await navigatorKey.currentState!.pushNamed(path, arguments: arguments);
  }

  @override
  Future<void> offAndNamed(String path, {Object? arguments}) async {
    await navigatorKey.currentState!.pushNamedAndRemoveUntil(path, removeAllOldRoutes, arguments: arguments);
  }

  @override
  Future<void> pop() async {
    navigatorKey.currentState!.pop();
  }
}
