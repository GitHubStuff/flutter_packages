import 'package:bloc/bloc.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:meta/meta.dart';

import '../../src/theme/default_themes.dart';
import '../../theme_management_package.dart';
import '../extensions/theme_mode_extensions.dart';

part '../hive/hive.dart';
part 'theme_cubit_state.dart';

class ThemeCubit extends Cubit<ThemeCubitState> {
  //Should be called BEFORE runApp()
  static setup() async {
    await _Hive.setup();
  }

  late ThemeData _darkTheme;
  late ThemeData _lightTheme;
  late ThemeIcons _themeIcons;

  ThemeCubit({ThemeData? darkTheme, ThemeData? lightTheme, ThemeIcons? themeIcons}) : super(ThemeCubitInitial()) {
    _darkTheme = darkTheme ?? DefaultThemes.defaultDarkThemeData;
    _lightTheme = lightTheme ?? DefaultThemes.defaultLightThemeData;
    _themeIcons = themeIcons ?? DefaultThemeIcons();
  }

  ThemeData get darkTheme => _darkTheme;
  ThemeData get lightTheme => _lightTheme;

  ThemeMode get themeMode => _Hive.getThemeMode();
  Widget themeModeIcon(BuildContext context) {
    switch (themeMode) {
      case ThemeMode.dark:
        return _themeIcons.applicationDark;
      case ThemeMode.light:
        return _themeIcons.applicationLight;
      case ThemeMode.system:
        final brightness = MediaQuery.of(context).platformBrightness;
        return (brightness == Brightness.dark) ? _themeIcons.platformDark : _themeIcons.platformLight;
    }
  }

  void setThemeMode(ThemeMode themeMode) {
    _Hive.setThemeMode(themeMode);
    emit(UpdateThemeMode(themeMode));
  }
}
