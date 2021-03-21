// Copyright 2021 LTMM. All rights reserved.
// Uses of this source code is governed by 'The Unlicense' that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../theme_package.dart';

/// This [abstract class] is used by as the extent of [StatefulWidget] to enable features like:
/// ```dart
/// afterFirstLayout
/// afterFirstLayoutComplete
/// reportTextScaleFactor - text scale setting set in system setting
/// didChangePlatformBrightness
/// didChangeAppLifecycleState
/// didChangeTextScaleFactor - notification the text scale was changed in the system settings
/// ```

abstract class ObservingStatefulWidget<T extends StatefulWidget> extends State<T> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    final instance = WidgetsBinding.instance;
    instance.addPostFrameCallback((_) => afterFirstLayout(context));
    instance.addPostFrameCallback((_) => afterFirstLayoutComplete(context));
    instance.addObserver(this);
    reportTextScaleFactor(instance.window.textScaleFactor);
  }

  // Called after layout
  void afterFirstLayout(BuildContext context) {
    context.read<ThemeCubit>().setInitialTheme(context);
  }

  void afterFirstLayoutComplete(BuildContext context);

  void reportTextScaleFactor(double textScaleFactor) {}

  @override
  void didChangePlatformBrightness() {
    super.didChangePlatformBrightness();
    final brightness = WidgetsBinding.instance.window.platformBrightness;
    this.context.read<ThemeCubit>().onPlatformBrightnessChanged(newBrightness: brightness);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {}

  @override
  void didChangeTextScaleFactor() {
    final textScalceFactor = WidgetsBinding.instance.window.textScaleFactor;
    reportTextScaleFactor(textScalceFactor);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
