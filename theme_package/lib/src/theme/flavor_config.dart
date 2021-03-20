// Copyright 2021 LTMM. All rights reserved.
// Uses of this source code is governed by 'The Unlicense' that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../src/app_exceptions/app_exceptions.dart';
import '../../theme_package.dart';
import 'flavor_banner.dart';

/// The [ThemeData], [theme properties], for dark/light theme are defined in [main.dart],
/// along with any [variables] for the [flavor]. This [FlavorConfig] is passed to [app_bloc.dart]

class FlavorConfig {
  static T lookup<T>(String key) => Modular.get<FlavorConfig>().constant<T>(key);

  /// Simple [helpers] to get common types from [flavor variable] values defined for a particualar flavor

  static FlavorConfig get _flavorConfig => Modular.get<FlavorConfig>();

  static ThemeType get themeType => _flavorConfig._themeType;
  static set themeType(ThemeType value) => (value != null) ? _flavorConfig._themeType = value : throw UnknownThemeType('Can not set to null');

  static ThemeData get darkThemeData => _flavorConfig._darkThemeData;
  static ThemeData get lightThemeData => _flavorConfig._lightThemeData;

  static Color color({@required String key}) => lookup<ColorsForTheme>(key).color;
  static String string({@required String key}) => lookup<String>(key);
  static TextStyle textStyle({@required String key}) => lookup<ThemeTextStyle>(key).style;

  final FlavorBanner flavorBanner;
  final LogLevel startingLogLevel;

  final ThemeData _darkThemeData;
  final ThemeData _lightThemeData;
  final Map<String, dynamic> _constants;

  ThemeType _themeType = ThemeType.unknown;

  FlavorConfig({
    @required this.flavorBanner,
    @required Map<String, dynamic> constants,
    @required ThemeData darkThemeData,
    @required ThemeData lightThemeData,
    @required this.startingLogLevel,
  })  : _darkThemeData = darkThemeData,
        _lightThemeData = lightThemeData,
        _constants = constants ?? Map() {
    assert(darkThemeData != null);
    assert(lightThemeData != null);
  }

  T constant<T>(String key) => (key != null && _constants[key] != null) ? _constants[key] as T : throw UnknownThemeProperty('no value for "$key"', 822);
}
