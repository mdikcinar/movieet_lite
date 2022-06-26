import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '0-core/init/navigation/navigation_route.dart';
import '0-core/init/navigation/navigation_service.dart';
import '0-core/init/theme/app_themes.dart';
import 'dashboard/view/dashboard_page.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movieet Lite',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: AppThemes.light.themeData,
      darkTheme: AppThemes.dark.themeData,
      navigatorObservers: [
        SentryNavigatorObserver(),
      ],
      navigatorKey: NavigationService.instance.navigatorKey,
      onGenerateRoute: NavigationRoute.instance.generateRoute,
      home: const DashboardPage(),
    );
  }
}
