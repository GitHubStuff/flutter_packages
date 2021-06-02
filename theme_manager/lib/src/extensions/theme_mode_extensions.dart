// Copyright 2021, LTMM LLC
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_extras/flutter_extras.dart';

import '../../theme_manager.dart';
import '../widgets/theme_icons.dart';

extension ThemeModeExtension on ThemeMode {
  Brightness asBrightness({required BuildContext context}) {
    switch (this) {
      case ThemeMode.dark:
        return Brightness.dark;
      case ThemeMode.light:
        return Brightness.light;
      case ThemeMode.system:
        return context.platformBrightness;
    }
  }

  String asString() => EnumToString.convertToString(this);

  Widget getIcon({required BuildContext context}) {
    ThemeIcons themeIcons = ThemeManager.themeIcons;
    switch (this) {
      case ThemeMode.dark:
        return themeIcons.applicationDark;
      case ThemeMode.light:
        return themeIcons.applicationLight;
      case ThemeMode.system:
        final brightness = context.platformBrightness;
        switch (brightness) {
          case Brightness.dark:
            return themeIcons.platformDark;
          case Brightness.light:
            return themeIcons.platformLight;
        }
    }
  }
}
