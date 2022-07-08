import 'package:chopper/chopper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieetlite/src/core/navigation/navigation_service.dart';
import 'package:movieetlite/src/features/dashboard/dashboard.dart';
import 'package:movieetlite/src/utils/routing/navigation_route.dart';
import 'package:movieetlite/src/utils/theme/app_themes.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class App extends StatelessWidget {
  const App(this._chopperClient, {super.key});

  final ChopperClient _chopperClient;

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
      home: RepositoryProvider(
        create: (context) => _chopperClient,
        child: const DashboardPage(),
      ),
    );
  }
}
