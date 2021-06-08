import 'package:app_exception/app_exception.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';

extension DateTimeExtension on String {
  DateTime get sqlite => DateTime.parse(this);

  ThemeMode asThemeMode() {
    ThemeMode? themeType = EnumToString.fromString<ThemeMode>(ThemeMode.values, this.toLowerCase());
    if (themeType == null) throw CannotReadThemeMode('Cannot read/parse "$this" as ThemeMode {system, light, dark}', 801);
    return themeType;
  }
}

class CannotReadThemeMode extends AppException {
  CannotReadThemeMode([String message = 'Invalid String', int code = 796]) : super(message, 'Cannot Read ThemeMode', code);
}
