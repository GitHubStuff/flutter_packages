part of '../cubit/theme_cubit.dart';

class _Hive {
  static const _boxName = 'com.icodeforyou.themeSetting';
  static Box? _box;
  static ThemeMode _placeHolder = ThemeMode.system;

  static Future<void> setup() async {
    try {
      await Hive.initFlutter();
      _box = await Hive.openBox<String>(_boxName);
    } on NullThrownError {} on MissingPluginException {} catch (e) {
      throw UnknownHiveException(e.toString());
    }
  }

  static ThemeMode getThemeMode() {
    final String storedValue = _box?.get(_boxName) ?? ThemeMode.system.asString();
    final ThemeMode? result = EnumToString.fromString(ThemeMode.values, storedValue);
    if (result == null) throw CannotReadThemeMode('value: $storedValue returned null');
    _placeHolder = result;
    _box?.put(_boxName, _placeHolder.asString());
    return _placeHolder;
  }

  static ThemeMode setThemeMode(ThemeMode themeMode) {
    _box?.put(_boxName, themeMode.asString());
    _placeHolder = themeMode;
    return _placeHolder;
  }
}
