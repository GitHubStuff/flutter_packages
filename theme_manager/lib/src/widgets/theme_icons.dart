// Copyright 2021, LTMM LLC
// This is an abstract class the is used with [Theme] to associate and [icon] with a given theme for [UI Display]
import 'package:flutter/material.dart';

abstract class ThemeIcons {
  final Widget applicationDark;
  final Widget applicationLight;
  final Widget platformDark;
  final Widget platformLight;
  final Widget platform;

  const ThemeIcons({
    required this.applicationDark,
    required this.applicationLight,
    required this.platformDark,
    required this.platformLight,
    required this.platform,
  });
}
