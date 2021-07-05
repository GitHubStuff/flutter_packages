import 'package:flutter_modular/flutter_modular.dart';
import 'package:theme_manager/theme_manager.dart';
import 'package:time_toggle_buttons/source/toggle_modular.dart';
import 'package:time_toggle_buttons/time_toggle_buttons.dart';

import 'scaffold_widget.dart';

class AppModule extends Module {
  // Provide a list of dependencies to inject into your project
  @override
  final List<Bind> binds = [
    Bind.singleton((i) => ThemeCubit()),
    Bind.singleton((i) => ToggleCubit()),
  ];

  // Provide all the routes for your module
  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, __) => ScaffoldWidget(title: 'empty_package')),
    ModuleRoute('/buttons', module: ToggleModular()),
  ];
}
