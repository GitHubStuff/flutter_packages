import 'package:bloc/bloc.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:meta/meta.dart';

import '../../src/colors/theme_colors_manager.dart';
import '../../src/theme/default_themes.dart';
import '../../theme_manager.dart';
import '../extensions/theme_mode_extensions.dart';

part '../hive/hive.dart';
part 'theme_cubit_state.dart';

class ThemeCubit extends Cubit<ThemeCubitState> {
  //Should be called BEFORE runApp()
  static setup() async => await _Hive.setup();

  static ThemeIcons _themeIcons = DefaultThemeIcons();
  static ThemeMode get themeMode => _Hive.getThemeMode();
  static Brightness brightness({required BuildContext? context}) => themeMode.asBrightness(context: context);
  static Widget themeModeIcon({required BuildContext context}) => themeMode.getIcon(context: context, usingThemeIcons: _themeIcons);
  static Color colorOf(String key, {required BuildContext context}) => ThemeColorsManager.by(
        key: key.toLowerCase(),
        themeMode: themeMode,
        using: context,
      );

  late ThemeData _darkTheme;
  late ThemeData _lightTheme;

  ThemeCubit({ThemeData? darkTheme, ThemeData? lightTheme, ThemeIcons? themeIcons}) : super(ThemeCubitInitial()) {
    _darkTheme = darkTheme ?? DefaultThemes.defaultDarkThemeData;
    _lightTheme = lightTheme ?? DefaultThemes.defaultLightThemeData;
    _themeIcons = themeIcons ?? DefaultThemeIcons();
  }

  ThemeData get darkTheme => _darkTheme;
  ThemeData get lightTheme => _lightTheme;
  ThemeIcons get themeIcons => _themeIcons;

  void setThemeMode(ThemeMode themeMode) {
    _Hive.setThemeMode(themeMode);
    emit(UpdateThemeMode(themeMode));
  }
}