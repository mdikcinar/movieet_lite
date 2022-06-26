import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../init/language/locale_keys.g.dart';
import '../../init/navigation/navigation_service.dart';

class RouteNotFoundPage extends StatelessWidget {
  final String? routeName;
  const RouteNotFoundPage({Key? key, required this.routeName}) : super(key: key);

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
