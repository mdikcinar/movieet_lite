import 'package:flutter/material.dart';

enum ColorTable {
  primaryColor,
  primaryColorLight,
  textColor,
  darkThemeTextColor;

  Color get color {
    switch (this) {
      case ColorTable.primaryColor:
        return const Color.fromARGB(255, 104, 247, 252);
      case ColorTable.primaryColorLight:
        return const Color.fromARGB(255, 211, 252, 253);
      case ColorTable.textColor:
        return const Color.fromARGB(255, 31, 31, 31);
      case ColorTable.darkThemeTextColor:
        return const Color.fromARGB(255, 255, 255, 255);
    }
  }
}
