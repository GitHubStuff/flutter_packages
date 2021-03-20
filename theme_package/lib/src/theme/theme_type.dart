// Copyright 2020 LTMM. All rights reserved.
// Uses of this source code is governed by 'The Unlicense' that can be
// found in the LICENSE file.

import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:theme_package/src/cubit_theme/theme_cubit.dart';

import '../../src/app_exception/app_exceptions.dart';
import '../../theme_package.dart';
import 'flavor_config.dart';

part 'brightness_extensions.dart';

/// There are two(2) categories of brightness:
/// * Application specific brightness, where the app ignores the platform brightness
/// * Platform brightness, where the app changes from light/dark themes when the device changes mode
/// This means there are four(4) flavors of modes:
/// * applicationDark - Dark theme used, ignoring platform brightness
/// * applicationLight - Light theme used, ignoring platform brightness
/// * platformDark - Dark theme is used, app abides by the devices setting to dark mode
/// * platformLight - Light theme is used, app abides by the devices setting to light mode
///
/// [ThemeType] defines values for the [platform brightness], or [application brightness](if used),
/// so that any changes (via app or platform) the category of brightness (appDark, platformDark,...)
/// is known and the correct theme is used.

extension ThemeTypeExtension on ThemeType {
  Brightness get brightness => this.themeData.brightness;

  ThemeMode get themeMode {
    switch (this) {
      case ThemeType.applicationLight:
        return ThemeMode.light;
      case ThemeType.applicationDark:
        return ThemeMode.dark;
      case ThemeType.platformDark:
      case ThemeType.platformLight:
        return ThemeMode.system;
      case ThemeType.unknown:
        throw UnknownThemeProperty('Cannot get themeMode for ".unknown"', 826);
      default:
        throw UnknownThemeMode('Unknown mode "$themeMode"', 827);
    }
  }

  ThemeData get themeData {
    switch (this) {
      case ThemeType.applicationLight:
      case ThemeType.platformLight:
        return FlavorConfig.lightThemeData;

      case ThemeType.applicationDark:
      case ThemeType.platformDark:
        return FlavorConfig.darkThemeData;

      /// When app is first launched, before the mode is read from preferences
      case ThemeType.unknown:
        switch (ThemeCubit.initialTheme.brightness) {
          case Brightness.dark:
            return FlavorConfig.darkThemeData;
          case Brightness.light:
            return FlavorConfig.lightThemeData;
          default:
            throw UnknownBrightnessType("Don't know $this", 823);
        }
        break;
      default:
        throw UnknownBrightnessType("Don't know $this", 810);
    }
  }

  ThemeType get toggle {
    switch (this) {
      case ThemeType.applicationDark:
        return ThemeType.applicationLight;
      case ThemeType.applicationLight:
        return ThemeType.applicationDark;
      case ThemeType.platformDark:
        return ThemeType.platformLight;
      case ThemeType.platformLight:
        return ThemeType.platformDark;
      default:
        throw UnknownBrightnessType("Don't know $this", 810);
    }
  }

  String get preferenceString => EnumToString.convertToString(this);

  static ThemeType from({@required String string}) {
    assert(string != null);
    assert(string.isNotEmpty);
    for (ThemeType value in ThemeType.values) {
      if (EnumToString.convertToString(value) == string) return value;
    }
    throw UnknownThemeType('Cannot parse $string', 821);
  }
}
