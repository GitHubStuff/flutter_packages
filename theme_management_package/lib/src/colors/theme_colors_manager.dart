import 'package:flutter/material.dart';

import '../../theme_management_package.dart';

class ThemeColorsManager {
  static Map<String, ThemeColors> _repository = {};

  static void add({
    required String key,
    required Color dark,
    required Color light,
  }) {
    if (key.isEmpty) throw EmptyKey();
    if (_repository[key.toLowerCase()] != null) throw DuplicateColor('$key already in list');
    _repository[key.toLowerCase()] = ThemeColors(dark: dark, light: light);
  }

  static void addMono({
    required Color color,
    required String key,
  }) =>
      add(key: key.toLowerCase(), dark: color, light: color);

  static Color by({
    required String key,
    required ThemeMode themeMode,
    required BuildContext? using,
  }) =>
      of(
        key.toLowerCase(),
        brightness: themeMode.asBrightness(context: using),
      );

  static Color of(String key, {required Brightness brightness}) {
    if (key.isEmpty) throw EmptyKey();
    if (_repository[key.toLowerCase()] == null) throw UnknownColor('Cannot find color key:$key');
    return (_repository[key.toLowerCase()]!).of(brightness);
  }

  static Color ofPlatformBrightness({
    required String key,
    required BuildContext context,
  }) =>
      of(
        key.toLowerCase(),
        brightness: context.platformBrightness,
      );
}
