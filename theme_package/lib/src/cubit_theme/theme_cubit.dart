// Copyright 2020 LTMM. All rights reserved.
// Uses of this source code is governed by 'The Unlicense' that can be
// found in the LICENSE file.

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:meta/meta.dart';

import '../../src/app_exceptions/app_exceptions.dart';
import '../../src/theme/theme_type.dart';
import '../../theme_package.dart';

part 'theme_state.dart';

/// This uses [bloc] package to seperate the [presentation] from [business logic]
/// allowing for modes (light/dark) to be precisely controled. This [BLoc] pattern
/// will respond to changes in the platform brightness, or the setting of the
/// application theme, and will [emit ThemeData] that the [ModularApp] widget
/// will respond to and redraw the app screen(s) in the desired theme

class ThemeCubit extends Cubit<ThemeData> {
  static final initialTheme = ThemeData(brightness: Brightness.light);

  /// [Constructor]
  ThemeCubit() : super(initialTheme);

  /// [Public methods]
  /// Should be called when the widget that contains MaterialApp is notified via WidgetsBindingObserver
  /// of changes in PlatformBrightness. Changes occur [only IF] the themes are tied to PlatformBrightness
  /// and not set by the user within an apps theme settings.
  void onPlatformBrightnessChanged({@required Brightness newBrightness}) {
    assert(newBrightness != null);
    switch (FlavorConfig.themeType) {

      /// Check if the app is managing brightness, is so ignore platform brightness
      case ThemeType.applicationLight:
      case ThemeType.applicationDark:
        return;

      /// App uses platform brightness
      case ThemeType.platformLight:
      case ThemeType.platformDark:
        if (newBrightness.asPlatformThemeType != FlavorConfig.themeType) {
          FlavorConfig.themeType = newBrightness.asPlatformThemeType;
          emit(FlavorConfig.themeType.themeData);
        }
        return;

      /// If a new mode is added, force and error to handle the new mode
      default:
        throw UnknownThemeType('${FlavorConfig.themeType} not in this version', 820);
    }
  }

  /// This should be called just below MaterialApp in the widget tree so that a context
  /// exists that can return platform brightness.
  /// NOTE: This should be called only once
  /// 1 - Create an addPostFrameCallback in initState
  /// [OR]
  /// 2 - Extend the StatefulWidget using ObservingStatefulWidget and call in 'afterFirstLayout'
  void setInitialTheme(BuildContext context) {
    /// On application cold start this will be null and will passthrough, for
    /// the rest of the application lifetime it will return early (see NOTE:)
    if (FlavorConfig.themeType != ThemeType.unknown) return;

    ThemePreference.getThemeType().then((ThemeType themeType) {
      switch (themeType) {
        case ThemeType.applicationDark:
        case ThemeType.applicationLight:
          FlavorConfig.themeType = themeType;
          break;

        case ThemeType.platformLight:
        case ThemeType.platformDark:
          final platformBrightness = MediaQuery.of(context).platformBrightness;
          FlavorConfig.themeType = platformBrightness.asPlatformThemeType;
          break;

        /// If a new mode is added, force and error to handle the new mode
        default:
          throw UnknownThemeType('$themeType not in this version', 819);
      }
      emit(FlavorConfig.themeType.themeData);
    });
  }

  void setToPlatformTheme(BuildContext context) {
    assert(context != null);
    final platformBrightness = MediaQuery.of(context).platformBrightness;
    FlavorConfig.themeType = platformBrightness.asPlatformThemeType;
    ThemePreference.setThemeType(themeType: FlavorConfig.themeType).then((_) {
      emit(FlavorConfig.themeType.themeData);
    });
  }

  void setApplicationToDarkTheme() {
    FlavorConfig.themeType = ThemeType.applicationDark;
    ThemePreference.setThemeType(themeType: FlavorConfig.themeType).then((_) {
      emit(FlavorConfig.themeType.themeData);
    });
  }

  void setApplicationToLightTheme() {
    FlavorConfig.themeType = ThemeType.applicationLight;
    ThemePreference.setThemeType(themeType: FlavorConfig.themeType).then((_) {
      emit(FlavorConfig.themeType.themeData);
    });
  }
}
