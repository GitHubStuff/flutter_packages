import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';

extension ThemeModeExtension on ThemeMode {
  String asString() => EnumToString.convertToString(this);
}
