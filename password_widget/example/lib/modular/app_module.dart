import 'package:flutter_modular/flutter_modular.dart';
import 'package:siginwidget/sigin_widget.dart';

import 'scaffold_widget.dart';

class AppModule extends Module {
  // Provide a list of dependencies to inject into your project
  @override
  final List<Bind> binds = [
    Bind.singleton((i) => SigninCubit()),
  ];

  // Provide all the routes for your module
  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, __) => ScaffoldWidget(title: 'siginwidget')),
  ];
}
