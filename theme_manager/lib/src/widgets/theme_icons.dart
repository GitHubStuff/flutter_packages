// Copyright 2021, LTMM LLC
// This is an abstract class the is used with [Theme] to associate and [icon] with a given theme for [UI Display]
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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

class DefaultThemeIcons implements ThemeIcons {
  Widget get applicationDark => FaIcon(FontAwesomeIcons.solidMoon, color: Colors.grey[400]);
  Widget get applicationLight => FaIcon(FontAwesomeIcons.solidSun, color: Colors.yellow[600]);
  Widget get platformDark => FaIcon(FontAwesomeIcons.lightbulb, color: Colors.grey[400]);
  Widget get platformLight => FaIcon(FontAwesomeIcons.solidLightbulb, color: Colors.yellow[600]);
  Widget get platform => FaIcon(FontAwesomeIcons.sun, color: Colors.amber[600]);
}
