// Copyright 2021 LTMM. All rights reserved.
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
