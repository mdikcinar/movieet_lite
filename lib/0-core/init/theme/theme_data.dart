import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class ThemeDataTable {
  static final darkThemeIconTheme = IconThemeData(color: ColorTable.darkThemeTextColor.color);
  static final lightThemeIconTheme = IconThemeData(color: ColorTable.textColor.color);
  static final fabButtonTheme = FloatingActionButtonThemeData(
    backgroundColor: ColorTable.primaryColor.color,
  );
}
