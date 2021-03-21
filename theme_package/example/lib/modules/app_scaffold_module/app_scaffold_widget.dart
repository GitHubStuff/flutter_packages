// Copyright 2020 LTMM. All rights reserved.
// Uses of this source code is governed by 'The Unlicense' that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:theme_package/theme_package.dart';
import 'package:provider/provider.dart';

import '../../template_widgets/body_widget.dart';
import '../../template_widgets/fab_widget.dart';

/// This is a [template widget] that is the base line to have an app that will
/// dynamically set the [Theme] for the app, either as the Platform theme,
/// or an app specific theme (store/manages a preference of the theme type [see: ThemeType enum])
/// NOTE: This is where properties of the [Scaffold] are made.
/// TODO: Make any additions to Scaffold here

class AppScaffoldWidget extends StatefulWidget {
  _AppScaffoldWidget createState() => _AppScaffoldWidget();
}

class _AppScaffoldWidget extends ObservingStatefulWidget<AppScaffoldWidget> {
  /// After the first layout read the preferences to see if the theme is the platform theme,
  /// application light theme, or application dark theme.
  void afterFirstLayout(BuildContext context) {
    context.read<ThemeCubit>().setInitialTheme(context);
  }

  void afterFirstLayoutComplete(BuildContext context) {
    Log.V('After firstlayout complete');
  }

  /// The app is set to recieve notification when the platform theme changes (from the device 'Settings')
  /// {notification is part of any widget that extends [ObservingStatefulWidget]}.
  // @override
  // void didChangePlatformBrightness() {
  //   final brightness = WidgetsBinding.instance.window.platformBrightness;
  //   this.context.read<ThemeCubit>().onPlatformBrightnessChanged(newBrightness: brightness);
  // }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('App Widget!!'),
      ),

      /// TODO: Change this widget to be the full screen: body_widget.dart is a good template for this
      body: BodyWidget(),

      /// TODO: Create, if needed, a FloatingActionButton
      /// NOTE: This template creates a column of floating action buttons that show examples of how
      /// NOTE: colors, text, etc change be changed
      floatingActionButton: FABWidget(),
    );
  }
}
