import 'package:flutter/material.dart';
import 'package:movieetlite/src/utils/constants/colors.dart';
import 'package:movieetlite/src/utils/theme/theme_data.dart';

enum AppThemes {
  dark,
  light;

  ThemeData get themeData {
    switch (this) {
      case AppThemes.light:
        return ThemeData(
          primaryColor: ColorTable.primaryColor.color,
          primaryColorLight: ColorTable.primaryColorLight.color,
          colorScheme: ColorScheme.fromSwatch().copyWith(
            brightness: Brightness.light,
            primary: ColorTable.primaryColor.color,
          ),
          textTheme: TextTheme(
            bodyMedium: TextStyle(
              color: ColorTable.textColor.color,
            ),
          ),
          iconTheme: ThemeDataTable.lightThemeIconTheme,
          appBarTheme: AppBarTheme(
            actionsIconTheme: IconThemeData(color: ColorTable.textColor.color),
            titleTextStyle: TextStyle(color: ColorTable.textColor.color, fontSize: 20),
            iconTheme: ThemeDataTable.lightThemeIconTheme,
          ),
          floatingActionButtonTheme: ThemeDataTable.fabButtonTheme,
        );
      case AppThemes.dark:
        return ThemeData(
          primaryColor: ColorTable.primaryColor.color,
          primaryColorLight: ColorTable.primaryColorLight.color,
          //toggleableActiveColor: Colors.pinkAccent,
          colorScheme: ColorScheme.fromSwatch().copyWith(
            brightness: Brightness.dark,
            primary: ColorTable.primaryColor.color,
          ),
          textTheme: TextTheme(
            bodyMedium: TextStyle(
              color: ColorTable.darkThemeTextColor.color,
            ),
          ),
          iconTheme: ThemeDataTable.darkThemeIconTheme,
          appBarTheme: AppBarTheme(
            actionsIconTheme: ThemeDataTable.darkThemeIconTheme,
            iconTheme: ThemeDataTable.darkThemeIconTheme,
          ),
          floatingActionButtonTheme: ThemeDataTable.fabButtonTheme,
        );
    }
  }
}
