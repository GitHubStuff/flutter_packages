// Copyright 2020 LTMM. All rights reserved.
// Uses of this source code is governed by 'The Unlicense' that can be
// found in the LICENSE file.
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:theme_package/theme_package.dart';
import 'package:tracers_package/tracers.dart';

import '../app_scaffold_module/app_scaffold_module.dart';
import 'material_app_bloc.dart';
import 'material_app_widget.dart';

/// Per flutter_modular this is the root/top of the Module for an app.
/// This module sets critial Binds:
/// -- [MaterialAppModule] for memory management
/// -- [FlavorConfig] that has themes, properties, etc for specific app flavors (release, debug, test,...)
/// The root/parent module is [AppScaffoldModule] that, in addition to other Bloc duties, points to the
/// first/root widget of the application
class MaterialAppModule extends Module {
  final FlavorConfig flavorConfig;
  MaterialAppModule({@required this.flavorConfig}) : assert(flavorConfig != null);

  @override
  List<Bind> get binds => [
        //Bind((i) => AppModule(flavorConfig: flavorConfig)),
        Bind((i) => MaterialAppWidget()),
        Bind((i) => flavorConfig),
        Bind.singleton((i) => Log.setTrace(baseLevel: flavorConfig.startingLogLevel)),
        Bind((i) => MaterialAppBloc()),
        Bind((i) => ThemeCubit()),

        /// TODO: Additional Bind beyond the template
      ];

  @override
  List<ModuleRoute> get routes => [
        ModuleRoute(Navigator.defaultRouteName, module: AppScaffoldModule()),
      ];
}
