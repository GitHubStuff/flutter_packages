// Copyright 2020 LTMM. All rights reserved.
// Uses of this source code is governed by 'The Unlicense' that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../theme_package.dart';
import 'theme_type_extension.dart';

/// Stores/Manages the theme mode (bright/dark) using preferences.
/// The values stored are strings derived from the flutter enum 'ThemeMode'
/// ```dart
/// ThemeMode.dark
/// ThemeMode.light
/// ThemeMode.system
/// ```
/// First time use return: ThemeMode.system

class ThemePreference {
  /// [Private]
  static const _THEME_MODE_PREFERENCE_PRIVATE_KEY = 'com.icodeforyou.theme_mode_preference';

  static Future<ThemeType> getThemeType() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final String themeModeText =
        sharedPreferences.getString(_THEME_MODE_PREFERENCE_PRIVATE_KEY) ?? ThemeType.platformDark.preferenceString;
    return ThemeTypeExtension.from(string: themeModeText);
  }

  static Future<void> setThemeType({@required ThemeType themeType}) async {
    assert(themeType != null);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(_THEME_MODE_PREFERENCE_PRIVATE_KEY, themeType.preferenceString);
  }
}
