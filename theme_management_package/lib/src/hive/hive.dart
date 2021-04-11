// Copyright 2021, LTMM
// Uses the Hive-NoSQL package to manage theme state (light, dark, or system)
//
// NOTE: For testing Hive won't work natively because the directory isn't defined, but _placeholder does so tests can be run
// - This effectively STUBS the service without have to swizzle in an alternative
part of '../cubit/theme_cubit.dart';

bool _hiveSetup = false;

class _Hive {
  static const _boxName = 'com.icodeforyou.themeSetting';
  static Box? _box;
  static ThemeMode _placeHolder = ThemeMode.system;

  static Future<void> setup() async {
    _hiveSetup = true;
    try {
      await Hive.initFlutter();
      _box = await Hive.openBox<String>(_boxName);
    } on NullThrownError {} on MissingPluginException {} catch (e) {
      throw UnknownHiveException(e.toString());
    }
  }

  static ThemeMode getThemeMode() {
    if (!_hiveSetup) throw IncompleteThemeCubit('Cannot getThemeMode()');
    final String storedValue = _box?.get(_boxName) ?? ThemeMode.system.asString();
    final ThemeMode? result = EnumToString.fromString(ThemeMode.values, storedValue);
    if (result == null) throw CannotReadThemeMode('value: $storedValue returned null');
    _placeHolder = result;
    _box?.put(_boxName, _placeHolder.asString());
    return _placeHolder;
  }

  static ThemeMode setThemeMode(ThemeMode themeMode) {
    if (!_hiveSetup) throw IncompleteThemeCubit('Cannot setThemeMode()');
    _box?.put(_boxName, themeMode.asString());
    _placeHolder = themeMode;
    return _placeHolder;
  }
}
