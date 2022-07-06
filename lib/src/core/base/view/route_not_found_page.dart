import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:movieetlite/src/core/navigation/navigation_service.dart';
import 'package:movieetlite/src/utils/language/locale_keys.g.dart';

class RouteNotFoundPage extends StatelessWidget {
  const RouteNotFoundPage({super.key, required this.routeName});
  final String? routeName;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(LocaleKeys.route_not_found.tr(args: [routeName ?? ''])),
          TextButton(onPressed: () => NavigationService.instance.pop(), child: Text(LocaleKeys.return_back.tr())),
        ],
      ),
    );
  }
}
