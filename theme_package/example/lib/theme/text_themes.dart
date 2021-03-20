// Copyright 2020 LTMM. All rights reserved.
// Uses of this source code is governed by 'The Unlicense' that can be
// found in the LICENSE file.


import 'package:flutter/material.dart';
import 'text_keys.dart';

part 'typography_mixin.dart';

/// This is a [helper] class that provides [default Themes] for [dark/light] mode including
/// [typography TextStyles] for [MaterialApp]
/// NOTE: In [main.dart] use [DefaultDarkThemeData] and [DefaultLightThemeData] as the basis of a [Flavor theme]
/// ```dart
/// final _darkTheme = DefaultDarkTheme.copyWith(....)
/// final _lightTheme = DefaultLightTheme.copyWith(...)
/// ```
/// NOTE: see [main_dev.dart] for example
/// 
// ignore: non_constant_identifier_names
ThemeData get DefaultDarkThemeData => ThemeData(brightness: Brightness.dark, textTheme: _TextThemeDefinations.dark);
// ignore: non_constant_identifier_names
ThemeData get DefaultLightThemeData => ThemeData(brightness: Brightness.light, textTheme: _TextThemeDefinations.light);
