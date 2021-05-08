import 'package:flutter_modular/flutter_modular.dart';
import 'package:location_package/location_package.dart';

import 'location_widget.dart';
import 'my_home_page.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (_, __) => MyHomePage(title: 'Flutter Demo Home Page')),
        ModuleRoute('/location', module: LocationModule(locationWidget: LocationWidget())),
      ];
}
