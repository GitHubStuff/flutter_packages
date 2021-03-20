// Copyright 2020 LTMM. All rights reserved.
// Uses of this source code is governed by 'The Unlicense' that can be
// found in the LICENSE file.

part of 'main.dart';

/// Values from the [share ../constants.dart] are [mapped] and paired with [values] that can be used anywhere in
/// the app. Allows creating [constants] for [flavors]
final Map<String, dynamic> _constants = {
  FlavorEnum.bulbColor.key: ColorsForTheme(dark: Colors.red, light: Colors.cyan),
  FlavorEnum.fabColor.key: ColorsForTheme(dark: Color(0xff9ccc65), light: Color(0xfff0cef8)),
  FlavorEnum.currentThemeIsPlatformLightIcon.key: FaIcon(FontAwesomeIcons.solidSun, color: Colors.yellow),
  FlavorEnum.currentThemeIsPlatformDarkIcon.key: FaIcon(FontAwesomeIcons.moon),
  FlavorEnum.currentThemeIsAppDarkIcon.key: FaIcon(FontAwesomeIcons.lightbulbSlash, color: Colors.grey),
  FlavorEnum.currentThemeIsAppLightIcon.key: FaIcon(FontAwesomeIcons.solidLightbulbOn, color: Colors.yellow),
  FlavorEnum.databaseName.key: 'devDatabase.db',
  FlavorEnum.setThemeDarkIcon.key: FaIcon(FontAwesomeIcons.lightbulbSlash),
  FlavorEnum.setThemeLightIcon.key: FaIcon(FontAwesomeIcons.lightbulbOn),
  FlavorEnum.setThemeDevice.key: FaIcon(FontAwesomeIcons.lightEclipseAlt),
  FlavorEnum.textColors.key: ColorsForTheme(dark: Colors.amber, light: Colors.purple),
  FlavorEnum.textStyle.key: ThemeTextStyle(textStyle: TextStyle(fontSize: 24.0), colorsForTheme: ColorsForTheme(dark: Colors.amber, light: Colors.purple)),
};
