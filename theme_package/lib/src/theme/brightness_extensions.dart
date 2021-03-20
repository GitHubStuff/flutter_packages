// Copyright 2020 LTMM. All rights reserved.
// Uses of this source code is governed by 'The Unlicense' that can be
// found in the LICENSE file.
part of 'theme_type.dart';

/// Extend Darts [Brightness]-enum to map to ThemeType
extension BrightnessThemeType on Brightness {
  ThemeType get asPlatformThemeType {
    switch (this) {
      case Brightness.dark:
        return ThemeType.platformDark;
      case Brightness.light:
        return ThemeType.platformLight;
      default:
        throw UnknownBrightnessType("Don't know brightness:$this", 805);
    }
  }
}
