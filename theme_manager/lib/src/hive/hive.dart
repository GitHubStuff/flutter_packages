// Copyright 2021, LTMM
// Uses the Hive-NoSQL package to manage theme state (light, dark, or system) for the application to persit across launches
//
// NOTE: For testing Hive won't work natively because the directory isn't defined, but _placeholder does so tests can be run
// - This effectively STUBS the service without have to swizzle in an alternative
part of '../theme_manager.dart';

bool _hiveSetup = false;

class _Hive {
  static const _boxName = 'com.icodeforyou.themeSetting';
  static Box? _box;
  static ThemeMode _themeMode = ThemeMode.system;

  static Future<void> setup() async {
    _hiveSetup = true;
    try {
      await Hive.initFlutter();
      _box = await Hive.openBox<String>(_boxName);
    } on NullThrownError {} on MissingPluginException {} catch (e) {
      throw UnknownHiveException(e.toString());
    }
  }

  static ThemeState _themeState(BuildContext context) {
    final mode = _getThemeMode();
    switch (mode) {
      case ThemeMode.dark:
        return ThemeState.applicationDark;
      case ThemeMode.light:
        return ThemeState.applicationLight;
      case ThemeMode.system:
        switch (context.platformBrightness) {
          case Brightness.dark:
            return ThemeState.platformDark;
          case Brightness.light:
            return ThemeState.platformLight;
        }
    }
  }

  static Brightness _brightness(BuildContext context) {
    final mode = _getThemeMode();
    switch (mode) {
      case ThemeMode.dark:
        return Brightness.dark;
      case ThemeMode.light:
        return Brightness.light;
      case ThemeMode.system:
        return context.platformBrightness;
    }
  }

  static ThemeMode _getThemeMode() {
    if (!_hiveSetup) throw IncompleteThemeCubit('Cannot getThemeMode()');
    final String storedValue = _box?.get(_boxName) ?? ThemeMode.system.asString();
    final ThemeMode? result = EnumToString.fromString(ThemeMode.values, storedValue);
    if (result == null) throw CannotReadThemeMode('value: $storedValue returned null');
    _themeMode = result;
    _box?.put(_boxName, _themeMode.asString());
    return _themeMode;
  }

  static ThemeMode _setThemeMode(ThemeMode themeMode) {
    if (!_hiveSetup) throw IncompleteThemeCubit('Cannot setThemeMode()');
    _box?.put(_boxName, themeMode.asString());
    _themeMode = themeMode;
    return _themeMode;
  }
}
