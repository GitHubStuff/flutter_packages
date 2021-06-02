import 'package:flutter/material.dart';

import '../app_exceptions.dart';
import 'theme_colors.dart';

String _reKey(String key) => (key.isNotEmpty) ? key.toLowerCase() : throw EmptyKey();

class ThemeColorsManager {
  static Map<String, ThemeColors> _repository = {};

  static void addColors({required String key, required Color dark, required Color light, bool allowOverrite = false}) =>
      addThemeColors(ThemeColors(dark: dark, light: light), forKey: key, allowOverwrite: allowOverrite);

  static void addThemeColors(ThemeColors colors, {required String forKey, bool allowOverwrite = false}) {
    if (!allowOverwrite && _lookupThemeColors(forKey, allowNull: true) != null) {
      throw DuplicateColor('ThemesColors for $forKey already exist');
    }
    _repository[_reKey(forKey)] = colors;
  }

  static Color color(String key, {required Brightness brightness}) => _lookupColor(key, brightness: brightness)!;

  static bool colorsExists({required String forKey}) => _repository.containsKey(_reKey(forKey));

  static initThemeColors(ThemeColors themeColors, {required String forKey}) => (!colorsExists(forKey: forKey)) ? addThemeColors(themeColors, forKey: forKey) : null;

  // static void replaceColors({required String key, required Color dark, required Color light, bool allowInsert = false}) =>
  //     replaceThemeColors(ThemeColors(dark: dark, light: light), forKey: key, allowInsert: allowInsert);

  static void replaceThemeColors(ThemeColors colors, {required String forKey, bool allowInsert = false}) {
    if (!allowInsert && _lookupThemeColors(forKey, allowNull: true) == null) {
      throw InvalidReplcement('ThemesColors for $forKey already exist');
    }
    _repository[_reKey(forKey)] = colors;
  }

  static Color? _lookupColor(String key, {required Brightness brightness, bool allowNull = false}) {
    final ThemeColors? themeColors = _lookupThemeColors(key, allowNull: allowNull);
    if (themeColors == null) return null;
    return (brightness == Brightness.dark) ? themeColors.dark : themeColors.light;
  }

  static ThemeColors? _lookupThemeColors(String key, {bool allowNull = false}) {
    final ThemeColors? result = _repository[_reKey(key)];
    if (!allowNull && result == null) throw UnknownColor('Cannot find ThemeColors for {$key}', 598);
    return result;
  }
}
