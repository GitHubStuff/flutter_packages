import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';

import 'app_exceptions.dart';

extension DateTimeExtension on String {
  DateTime get sqlite => DateTime.parse(this);

  ThemeMode asThemeMode() {
    ThemeMode? themeType = EnumToString.fromString<ThemeMode>(ThemeMode.values, this);
    if (themeType == null) throw CannotReadThemeMode('Cannot read/parse "$this" as ThemeMode {system, light, dark}');
    return themeType;
  }
}
