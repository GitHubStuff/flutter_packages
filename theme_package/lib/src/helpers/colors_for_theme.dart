// Copyright 2021 LTMM. All rights reserved.

import 'package:flutter/material.dart';

import '../../theme_package.dart';
import '../theme/theme_type_extension.dart';

/// Stores colors for dark/light modes. The color of the current theme is
/// returned by [color] inline method that gets the current mode and returns
/// the correct color
/// NOTE: this is for one-of colors outside the colors used by [ThemeData]

class ColorsForTheme {
  final Color _dark;
  final Color _light;
  ColorsForTheme({@required Color dark, @required Color light})
      : assert(dark != null && light != null),
        _dark = dark,
        _light = light;
  factory ColorsForTheme.mono({@required Color color}) => ColorsForTheme(dark: color, light: color);

  Color get color {
    final brightness = FlavorConfig.themeType.brightness;
    return of(brightness: brightness);
  }

  Color of({@required Brightness brightness}) {
    //FIX : When colors for dark them
    final result = (brightness == Brightness.dark) ? _light : _light;
    return result;
  }
}
