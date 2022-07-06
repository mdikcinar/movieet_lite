import 'package:flutter/material.dart';
import 'package:movieetlite/src/utils/constants/colors.dart';

class ThemeDataTable {
  static final darkThemeIconTheme = IconThemeData(color: ColorTable.darkThemeTextColor.color);
  static final lightThemeIconTheme = IconThemeData(color: ColorTable.textColor.color);
  static final fabButtonTheme = FloatingActionButtonThemeData(
    backgroundColor: ColorTable.primaryColor.color,
  );
}
