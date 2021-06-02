import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_extras/flutter_extras.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:theme_manager/src/colors/theme_colors_manager.dart';
import 'package:theme_manager/src/theme/default_themes.dart';

import 'app_exceptions.dart';
import 'colors/theme_colors.dart';
import 'cubit/theme_cubit.dart';
import 'extensions/theme_mode_extensions.dart';
import 'theme/theme_state.dart';
import 'widgets/default_theme_icons.dart';
import 'widgets/theme_icons.dart';

part '../src/hive/hive.dart';

class ThemeManager {
  //static ThemeManager get singleton => _instance ?? ThemeManager();

  static final ThemeCubit _themeCubit = ThemeCubit();

  static late ThemeManager? _instance;

  static ThemeIcons? _themeIcons;

  static ThemeData? _darkTheme;

  static ThemeData? _lightTheme;

  static ThemeData get darkTheme => _darkTheme ?? DefaultThemes.defaultDarkThemeData;
  static ThemeData get lightTheme => _lightTheme ?? DefaultThemes.defaultLightThemeData;
  static ThemeCubit get themeCubit => _themeCubit;
  static ThemeIcons get themeIcons => _themeIcons ?? DefaultThemeIcons();

  static ThemeMode get themeMode => _Hive._getThemeMode();

  static set themeMode(ThemeMode mode) {
    _Hive._setThemeMode(mode);
    _themeCubit.emit(UpdateThemeMode(mode));
  }

  factory ThemeManager({
    ThemeData? darkTheme,
    ThemeData? lightTheme,
    ThemeIcons? themeIcons,
    Map<String, ThemeColors>? colorMap,
  }) {
    _instance = ThemeManager._internal(
      darkTheme ?? DefaultThemes.defaultDarkThemeData,
      lightTheme ?? DefaultThemes.defaultLightThemeData,
      themeIcons ?? DefaultThemeIcons(),
    );
    colorMap?.forEach((key, value) => ThemeColorsManager.replaceThemeColors(value, forKey: key, allowInsert: true));
    return _instance!;
  }

  ThemeManager._internal(ThemeData darkTheme, ThemeData lightTheme, ThemeIcons themeIcons) {
    _themeIcons = themeIcons;
    _darkTheme = darkTheme;
    _lightTheme = lightTheme;
    _themeIcons = themeIcons;
    _instance = this;
  }

  static void defaultThemeColors(ThemeColors themeColors, {required String forKey}) => ThemeColorsManager.initThemeColors(
        themeColors,
        forKey: forKey,
      );

  static void addThemeColors(ThemeColors colors, {required String forKey, bool allowOverwrite = false}) => ThemeColorsManager.addThemeColors(
        colors,
        forKey: forKey,
      );

  static Brightness brightness(BuildContext context) => _Hive._brightness(context);

  static Color color(String key, {required BuildContext context}) => ThemeColorsManager.color(key, brightness: brightness(context));

  static setup() async => await _Hive.setup();

  static Widget themeModeIcon(BuildContext context) => _Hive._getThemeMode().getIcon(context: context);

  static ThemeState themeState(BuildContext context) => _Hive._themeState(context);

  //static bool missingColors({required String forKey}) => !ThemeColorsManager.colorsExists(forKey: forKey);
}
