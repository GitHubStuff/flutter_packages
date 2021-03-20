// Copyright 2020 LTMM. All rights reserved.
// Uses of this source code is governed by 'The Unlicense' that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:theme_package/theme_package.dart';

import '../../modules/material_app_module/material_app_module.dart';
import '../../theme/text_themes.dart';
import '../flavor_enum.dart';

part 'constants.dart';
part 'define_themes.dart';

final _flavorConfig = FlavorConfig(
  flavorBanner: null,
  darkThemeData: _darkThemeData,
  lightThemeData: _lightThemeData,
  constants: _constants,
  startingLogLevel: LogLevel.All,
);

void main() {
  /// [Logs to console] changes by observing all [BLoc] and [Cubit]
  Bloc.observer = SimpleBlocObserver();
  runApp(ModularApp(module: MaterialAppModule(flavorConfig: _flavorConfig)));
}
