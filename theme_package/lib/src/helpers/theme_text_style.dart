// Copyright 2020 LTMM. All rights reserved.
// Uses of this source code is governed by 'The Unlicense' that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

import '../../theme_package.dart';

/// Helper to create [TextStyle] that has theme that extends to applying
/// a [Color] base on the dark/light mode.
/// NOTE: this is for one-of colors outside the [ThemeData]

class ThemeTextStyle extends TextStyle {
  final TextStyle textStyle;
  final ColorsForTheme colorsForTheme;
  ThemeTextStyle({@required this.textStyle, @required this.colorsForTheme});

  TextStyle get style => textStyle.apply(color: colorsForTheme?.color);
}
