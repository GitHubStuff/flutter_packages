import 'package:bloc/bloc.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_extras/flutter_extras.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:meta/meta.dart';

import '../../src/theme/default_themes.dart';
import '../../src/theme/theme_state.dart';
import '../../theme_manager.dart';
import '../extensions/theme_mode_extensions.dart';

part '../hive/hive.dart';
part 'theme_cubit_state.dart';

class ThemeCubit extends Cubit<ThemeCubitState> {
  //Should be called BEFORE runApp()
  static ThemeIcons _themeIcons = DefaultThemeIcons();

  static ThemeMode get themeMode => _Hive._getThemeMode();

  late ThemeData _darkTheme;

  late ThemeData _lightTheme;

  ThemeCubit({
    ThemeData? darkTheme,
    ThemeData? lightTheme,
    ThemeIcons? themeIcons,
    Map<String, ThemeColors>? colorMap,
  }) : super(ThemeCubitInitial()) {
    _darkTheme = darkTheme ?? DefaultThemes.defaultDarkThemeData;
    _lightTheme = lightTheme ?? DefaultThemes.defaultLightThemeData;
    _themeIcons = themeIcons ?? DefaultThemeIcons();
    colorMap?.forEach((key, value) => ThemeColorsManager.addThemeColors(value, forKey: key, allowOverwrite: true));
  }

  ThemeData get darkTheme => _darkTheme;

  // static Brightness brightness({required BuildContext? context}) => themeMode.asBrightness(context: context);
  // static Color colorOf(String key, {required BuildContext context}) => ThemeColorsManager.color(key, brightness: themeMode.asBrightness(context: context));

  ThemeData get lightTheme => _lightTheme;
  ThemeIcons get themeIcons => _themeIcons;

  void setThemeMode(ThemeMode themeMode) {
    _Hive._setThemeMode(themeMode);
    emit(UpdateThemeMode(themeMode));
  }

  static Brightness brightness({required BuildContext context}) => _Hive._brightness(context);
  static Color color({required String key, required BuildContext context}) => ThemeColorsManager.color(
        key,
        brightness: brightness(context: context),
      );
  static setup() async => await _Hive.setup();
  static Widget themeModeIcon({required BuildContext context}) => _Hive._getThemeMode().getIcon(
        context: context,
        usingThemeIcons: _themeIcons,
      );

  static ThemeState themeState({required BuildContext context}) => _Hive._themeState(context);
}
