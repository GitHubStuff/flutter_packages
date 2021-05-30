import 'package:flutter/material.dart';

import '../../theme_manager.dart';

String _reKey(String key) => (key.isNotEmpty) ? key.toLowerCase() : throw EmptyKey();

class ThemeColorsManager {
  static Map<String, ThemeColors> _repository = {};

  static void addThemeColors(ThemeColors colors, {required String forKey, bool allowOverwrite = false}) {
    if (!allowOverwrite && _lookupThemeColors(forKey, allowNull: true) != null) {
      throw DuplicateColor('ThemesColors for $forKey already exist');
    }
    _repository[_reKey(forKey)] = colors;
  }

  static void addColors({required String key, required Color dark, required Color light, bool allowOverrite = false}) =>
      addThemeColors(ThemeColors(dark: dark, light: light), forKey: key, allowOverwrite: allowOverrite);

  static void replaceThemeColors(ThemeColors colors, {required String forKey, bool allowInsert = false}) {
    if (!allowInsert && _lookupThemeColors(forKey, allowNull: true) == null) {
      throw InvalidReplcement('ThemesColors for $forKey already exist');
    }
    _repository[_reKey(forKey)] = colors;
  }

  static void replaceColors({required String key, required Color dark, required Color light, bool allowInsert = false}) =>
      replaceThemeColors(ThemeColors(dark: dark, light: light), forKey: key, allowInsert: allowInsert);

  static Color color(String key, {required Brightness brightness}) => _lookupColor(key, brightness: brightness)!;

  static ThemeColors? _lookupThemeColors(String key, {bool allowNull = false}) {
    final ThemeColors? result = _repository[_reKey(key)];
    if (!allowNull && result == null) throw UnknownColor('Cannot find ThemeColors for {$key}', 598);
    return result;
  }

  static Color? _lookupColor(String key, {required Brightness brightness, bool allowNull = false}) {
    final ThemeColors? themeColors = _lookupThemeColors(key, allowNull: allowNull);
    if (themeColors == null) return null;
    return (brightness == Brightness.dark) ? themeColors.dark : themeColors.light;
  }
/*
  static void add({
    required String key,
    required Color dark,
    required Color light,
  }) {
    key = _reKey(key);
    if (_repository[key] != null) throw DuplicateColor('$key already in list');
    _repository[key] = ThemeColors(dark: dark, light: light);
  }

  static void addMono({
    required Color color,
    required String key,
  }) =>
      add(key: _reKey(key), dark: color, light: color);

  static Color by({
    required String key,
    required ThemeMode themeMode,
    required BuildContext? using,
  }) =>
      of(
        _reKey(key),
        brightness: themeMode.asBrightness(context: using),
      );

  static Color of(String key, {required Brightness brightness}) {
    key = _reKey(key);
    if (_repository[key] == null) throw UnknownColor('Cannot find color key:$key');
    return (_repository[key]!).of(brightness);
  }

  static Color ofPlatformBrightness({
    required String key,
    required BuildContext context,
  }) =>
      of(
        _reKey(key),
        brightness: context.platformBrightness,
      );

  static ThemeColors colors({required String key}) {
    key = _reKey(key);
    if (_repository[key] == null) throw UnknownColor('Cannot find color key:$key');
    return _repository[key]!;
  }

  static void replace({required String key, required Color dark, required Color light, bool check = false}) {
    key = _reKey(key);
    if (check && _repository[key] == null) throw InvalidReplcement('No current color for $key');
    _repository[key] = ThemeColors(dark: dark, light: light);
  }
  */
}
