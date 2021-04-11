import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';

import '../app_exceptions.dart';

extension StringExtension on String {
  ThemeMode asThemeType() {
    ThemeMode? themeType = EnumToString.fromString<ThemeMode>(ThemeMode.values, this);
    if (themeType == null) throw CannotReadThemeMode('Cannot read/parse $this');
    return themeType;
  }
}
