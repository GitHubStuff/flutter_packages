import 'package:app_exception/app_exception.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

extension StringExtensions on String {
  static String get uniqueKey => Uuid().v4();

  DateTime get sqlite => DateTime.parse(this);

  ThemeMode asThemeMode() {
    ThemeMode? themeType = EnumToString.fromString<ThemeMode>(ThemeMode.values, this.toLowerCase());
    if (themeType == null) throw CannotParseThemeModeFromString('Cannot read/parse "$this" as ThemeMode {system, light, dark}', 801);
    return themeType;
  }
}

class CannotParseThemeModeFromString extends AppException {
  CannotParseThemeModeFromString([String message = 'Invalid String', int code = 796])
      : super(
          message,
          'Cannot Read ThemeMode',
          code,
        );
}
