// Copyright 2021, LTMM LLC
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';

import '../../theme_management_package.dart';

extension ThemeModeExtension on ThemeMode {
  Brightness asBrightness({required BuildContext? context}) {
    switch (this) {
      case ThemeMode.dark:
        return Brightness.dark;
      case ThemeMode.light:
        return Brightness.light;
      case ThemeMode.system:
        if (context == null) throw RequiresContext('ThemeMode.asBrightness() => needs context');
        return MediaQuery.of(context).platformBrightness;
    }
  }

  String asString() => EnumToString.convertToString(this);

  Widget getIcon({required BuildContext context, required ThemeIcons usingThemeIcons}) {
    switch (this) {
      case ThemeMode.dark:
        return usingThemeIcons.applicationDark;
      case ThemeMode.light:
        return usingThemeIcons.applicationLight;
      case ThemeMode.system:
        final brightness = MediaQuery.of(context).platformBrightness;
        switch (brightness) {
          case Brightness.dark:
            return usingThemeIcons.platformDark;
          case Brightness.light:
            return usingThemeIcons.platformLight;
        }
    }
  }
}
