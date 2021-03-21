// Copyright 2020 LTMM. All rights reserved.
// Uses of this source code is governed by 'The Unlicense' that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'app_scaffold_widget.dart';

class AppScaffoldModule extends ChildModule {
  @override
  List<Bind> get binds => [];

  /// NOTE: the differences between ModularRouter(child:), and ModularRouter(module:)
  @override
  List<ModularRouter> get routers => [
        ModularRouter(Navigator.defaultRouteName, child: (context, args) => AppScaffoldWidget()),
      ];
}
