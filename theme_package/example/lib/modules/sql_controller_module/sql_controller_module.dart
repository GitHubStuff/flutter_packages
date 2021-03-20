// Copyright 2021 LTMM. All rights reserved.
// Uses of this source code is governed by 'The Unlicense' that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'cubit/sqlite_cubit.dart';
import 'sql_controller_widget.dart';

class SqlControllerModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => SqliteCubit()),
      ];

  /// NOTE: the differences between ModularRouter(child:), and ModularRouter(module:)
  @override
  List<ModularRouter> get routers => [
        ModularRouter(Navigator.defaultRouteName, child: (context, args) => SqlControllerWidget()),
      ];
}
