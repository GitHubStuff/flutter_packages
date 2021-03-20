// Copyright 2020 LTMM. All rights reserved.
// Uses of this source code is governed by 'The Unlicense' that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:theme_package/theme_package.dart';

import '../localization/localization.dart';
import '../main/flavor_enum.dart';

/// This is a [helper] class that displays a custom [Alert Dialog] that allows the user
/// to change the [ModeTheme] to [Dark, Light, Platform]

const widgetHorizontalSpace = 8.0;

class SetThemeDialog {
  static void show(BuildContext context) {
    /// [Column] of widgets that appear as the [Alert content], it shows the current [theme] and [user instructions]
    Column alertContent(String message, FaIcon icon) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(children: [
              Text(localize(context, message)),
              Container(width: widgetHorizontalSpace),
              icon,
            ]),
            Container(height: widgetHorizontalSpace),
            Text(localize(context, 'setThemeContent')),
          ],
        );

    /// Helper to compose [Alert response buttons]
    FlatButton flatButton(String text, Widget icon, VoidCallback onPress) {
      return FlatButton(
        child: Row(
          children: [Text(localize(context, text)), Container(width: (icon == null) ? 1 : widgetHorizontalSpace), icon ?? Container(width: 1)],
          mainAxisAlignment: MainAxisAlignment.end,
        ),
        onPressed: () {
          Navigator.of(context, rootNavigator: true).pop();
          onPress();
        },
      );
    }

    Column alertContentColums;
    switch (FlavorConfig.themeType) {
      case ThemeType.applicationDark:
        alertContentColums = alertContent('themeAppDark', FlavorEnum.currentThemeIsAppDarkIcon.icon);
        break;
      case ThemeType.applicationLight:
        alertContentColums = alertContent('themeAppLight', FlavorEnum.currentThemeIsAppLightIcon.icon);
        break;
      case ThemeType.platformDark:
        alertContentColums = alertContent('themeDeviceDark', FlavorEnum.currentThemeIsPlatformDarkIcon.icon);
        break;
      case ThemeType.platformLight:
        alertContentColums = alertContent('themeDeviceLight', FlavorEnum.currentThemeIsPlatformLightIcon.icon);
        break;
      default:
        throw 'Unknown ThemeType ${FlavorConfig.themeType}';
    }

    final AlertDialog alert = AlertDialog(
      title: Text(localize(context, 'setTheme')),
      content: alertContentColums,
      actions: [
        flatButton(
          'setThemeLight',
          FlavorEnum.setThemeLightIcon.icon,
          context.read<ThemeCubit>().setApplicationToLightTheme,
        ),
        flatButton(
          'setThemeDark',
          FlavorEnum.setThemeDarkIcon.icon,
          context.read<ThemeCubit>().setApplicationToDarkTheme,
        ),
        flatButton('setThemePlatform', FlavorEnum.setThemeDevice.icon, () {
          context.read<ThemeCubit>().setToPlatformTheme(context);
        }),
        flatButton(
          'cancel',
          null,
          () {},
        ),
      ],
    );

    showDialog(
      context: context,
      builder: (_) => alert,
    );
  }
}
