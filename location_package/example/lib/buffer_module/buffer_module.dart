import 'package:flutter_modular/flutter_modular.dart';

import 'buffer_widget.dart';

class BufferModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        //ModuleRoute('/', module: LocationModule(locationWidget: LocationWidget())),
        ChildRoute('/', child: (_, __) => BufferWidget(title: 'Buffer Widget')),
      ];
}
