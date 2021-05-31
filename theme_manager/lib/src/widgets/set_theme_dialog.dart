// Copyright 2021 LTMM. All rights reserved.
// This is a US-English only dialog that can be used to set the theme of the application.
import 'package:flutter/material.dart';

import '../../../theme_manager.dart';
import '../../src/extensions/text_keys_extension.dart';
import '../../src/theme/text_keys.dart';
import '../../src/theme/theme_state.dart';

/// This is a [helper] class that displays a custom [Alert Dialog] that allows the user
/// to change the [ModeTheme] to [Dark, Light, Platform]

const _widgetHorizontalSpace = 8.0;

class SetThemeDialog {
  static void show({required BuildContext context}) {
    final _style = TextKey.headline6.asTextStyle(forBrightness: ThemeManager.brightness(context));
    final _title = TextKey.headline5.asTextStyle(forBrightness: ThemeManager.brightness(context));

    /// [Column] of widgets that appear as the [Alert content], it shows the [title], current [theme], and [user instructions]
    Column alertContent(String message) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Currently:',
              style: _style,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 4),
                  child: Text(
                    '$message ',
                    style: _style,
                  ),
                ),
                ThemeManager.themeModeIcon(context), // Icon of the current theme
              ],
            ),
            Container(height: _widgetHorizontalSpace),
            Text(
              'Set the theme to light, dark, or match device theme.',
              style: _style,
            ),
          ],
        );

    /// Helper to compose [Alert response buttons]. The widget will display the [theme prompt], and the [icon] of that theme
    TextButton flatButton(String text, Widget? icon, VoidCallback onPress) {
      return TextButton(
        child: Row(
          children: [
            Text(
              text,
              style: _style,
            ),
            Container(width: (icon == null) ? 1 : _widgetHorizontalSpace), //[Cancel] button has no icon
            icon ?? Container(width: 1)
          ],
          mainAxisAlignment: MainAxisAlignment.end,
        ),
        onPressed: () {
          Navigator.of(context, rootNavigator: true).pop();
          onPress();
        },
      );
    }

    Column alertContentColumns;

    switch (ThemeManager.themeState(context)) {
      case ThemeState.applicationDark:
        alertContentColumns = alertContent('Application Dark');
        break;
      case ThemeState.applicationLight:
        alertContentColumns = alertContent('Application Light');
        break;
      case ThemeState.platformDark:
        alertContentColumns = alertContent('Platform dark');
        break;
      case ThemeState.platformLight:
        alertContentColumns = alertContent('Platform light');
        break;
    }

    final AlertDialog alert = AlertDialog(
      title: Text('Set Theme', style: _title),
      content: alertContentColumns,
      actions: [
        flatButton(
          'Application Dark',
          ThemeManager.themeIcons.applicationDark,
          () => ThemeManager.themeMode = ThemeMode.dark,
        ),
        flatButton(
          'Application Light',
          ThemeManager.themeIcons.applicationLight,
          () => ThemeManager.themeMode = ThemeMode.light,
        ),
        flatButton(
          'Platform',
          (MediaQuery.of(context).platformBrightness == Brightness.dark ? ThemeManager.themeIcons.platformDark : ThemeManager.themeIcons.platformLight),
          () => ThemeManager.themeMode = ThemeMode.system,
        ),
        flatButton(
          'Cancel',
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
