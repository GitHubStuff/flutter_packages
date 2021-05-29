import 'package:flutter/material.dart';
import 'package:flutter_extras/flutter_extras.dart';

import '../../theme_manager.dart';

String _reKey(String key) => (key.isNotEmpty) ? key.toLowerCase() : throw EmptyKey();

class ThemeColorsManager {
  static Map<String, ThemeColors> _repository = {};

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

  static ThemeColors themeColors({required String forKey}) {
    forKey = _reKey(forKey);
    if (_repository[forKey] == null) throw UnknownColor('Cannot find color key:$forKey');
    return _repository[forKey]!;
  }

  static void replace({required String key, required Color dark, required Color light, bool check = false}) {
    key = _reKey(key);
    if (check && _repository[key] == null) throw InvalidReplcement('No current color for $key');
    _repository[key] = ThemeColors(dark: dark, light: light);
  }
}
