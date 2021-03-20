// Copyright 2020 LTMM. All rights reserved.
// Uses of this source code is governed by 'The Unlicense' that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:theme_package/theme_package.dart';

import '../main/flavor_enum.dart';
import 'set_theme_dialog.dart';

/// This is a simple [Column widget template] with a collection of [Floating Action Buttons] that
/// is the parameter to the [Scaffold] in [app_scaffold_widget.dart template].
/// NOTE: this shows more examples of how, with [flutter_modular] to get [variables] that are
/// NOTE: defined a specific [Flavor] (eg: production, test, debug,...)

class FABWidget extends StatelessWidget {
  Widget build(BuildContext context) {
    /// NOTE: example of creating a placeholder and getting a [ColorsForTheme] variable
    Color bulbColor = FlavorEnum.bulbColor.themeColor;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: FloatingActionButton(
            heroTag: 'alarmThis',

            /// NOTE: example using [FlavorConfig] helper to get also get a color
            /// NOTE: (its helper to replace the call used for [bulbColor])
            backgroundColor: FlavorEnum.fabColor.themeColor,
            child: const Icon(Icons.brightness_6),
            onPressed: () {
              SetThemeDialog.show(context);
              //Scaffold.of(context).hideCurrentSnackBar();
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: FloatingActionButton(
            heroTag: 'platformBrightness',
            backgroundColor: Colors.amber,
            child: const Icon(Icons.alarm),
            onPressed: () {
              context.read<ThemeCubit>().setToPlatformTheme(context);
              final snackBar = SnackBar(
                content: Text('ALARM-IE'),
                duration: Duration(milliseconds: 800),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: FloatingActionButton(
            heroTag: 'applicationLight',

            /// NOTE: this uses the value of [bulbColor] defined above
            backgroundColor: bulbColor,
            child: const Icon(Icons.lightbulb_outline_sharp),
            onPressed: () {
              context.read<ThemeCubit>().setApplicationToLightTheme();
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: FloatingActionButton(
            /// Uses the colors defined in the [Theme]
            heroTag: 'applicationDart',
            child: const Icon(Icons.lightbulb),
            onPressed: () {
              context.read<ThemeCubit>().setApplicationToDarkTheme();
            },
          ),
        ),
      ],
    );
  }
}
