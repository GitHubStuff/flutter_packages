// Copyright 2021 LTMM. All rights reserved.
//
import 'package:flutter/material.dart';

/// [Helper enum]
/// This defines an [enum] to use with [TextTheme sizes], and [light/dark text colors] for properties in the
/// [MaterialApp TextStyle] design (e.g. [headline1, headline2, bodyText,...])

enum TextKey {
  headline1,
  headline2,
  headline3,
  headline4,
  headline5,
  headline6,
  subtitle1,
  subtitle2,
  bodyText1,
  bodyText2,
  caption,
  button,
  overline,
}

// Font sizes
Map<TextKey, double> textSizeMap = {
  TextKey.headline1: 96.0,
  TextKey.headline2: 60.0,
  TextKey.headline3: 48.0,
  TextKey.headline4: 32.0,
  TextKey.headline5: 24.0,
  TextKey.headline6: 20.0,
  TextKey.subtitle1: 16.0,
  TextKey.subtitle2: 14.0,
  TextKey.bodyText1: 16.0,
  TextKey.bodyText2: 15.0,
  TextKey.button: 14.0,
  TextKey.caption: 12.0,
  TextKey.overline: 10.0,
};

Map<TextKey, Color> textColorLightMode = {
  TextKey.headline1: Colors.black,
  TextKey.headline2: Colors.black,
  TextKey.headline3: Colors.black,
  TextKey.headline4: Colors.black,
  TextKey.headline5: Colors.black,
  TextKey.headline6: Colors.black,
  TextKey.subtitle1: Colors.black,
  TextKey.subtitle2: Colors.black,
  TextKey.bodyText1: Colors.black,
  TextKey.bodyText2: Colors.black,
  TextKey.button: Colors.black,
  TextKey.caption: Colors.black,
  TextKey.overline: Colors.black,
};

Map<TextKey, Color> textColorDarkMode = {
  TextKey.headline1: Colors.yellow[300]!,
  TextKey.headline2: Colors.yellow[300]!,
  TextKey.headline3: Colors.yellow[300]!,
  TextKey.headline4: Colors.yellow[300]!,
  TextKey.headline5: Colors.yellow[300]!,
  TextKey.headline6: Colors.yellow[300]!,
  TextKey.subtitle1: Colors.yellow[300]!,
  TextKey.subtitle2: Colors.yellow[300]!,
  TextKey.bodyText1: Colors.yellow[300]!,
  TextKey.bodyText2: Colors.yellow[300]!,
  TextKey.button: Colors.yellow[300]!,
  TextKey.caption: Colors.yellow[300]!,
  TextKey.overline: Colors.yellow[300]!,
};
