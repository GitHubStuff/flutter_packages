// Copyright 2021 LTMM. All rights reserved.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:template/modules/material_app_module/material_app_widget.dart';
import 'package:theme_package/theme_package.dart';
import 'package:tracers_package/tracers.dart';

import '../../modules/material_app_module/material_app_module.dart';
import '../../theme/text_themes.dart';
import '../flavor_enum.dart';

part 'constants.dart';
part 'define_themes.dart';

final _banner = FlavorBanner(name: 'FHCP', color: Colors.purple);

final _flavorConfig = FlavorConfig(
  constants: _constants,
  darkThemeData: _darkThemeData,
  flavorBanner: _banner,
  lightThemeData: _lightThemeData,
  startingLogLevel: LogLevel.All,
);

void main() {
  /// [Logs to console] changes by observing all [BLoC] and [Cubit]
  Bloc.observer = SimpleBlocObserver();
  runApp(ModularApp(
    module: MaterialAppModule(flavorConfig: _flavorConfig),
    child: MaterialAppWidget(),
  ));
}
