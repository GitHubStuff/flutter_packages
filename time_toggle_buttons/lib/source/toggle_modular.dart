import 'package:flutter_modular/flutter_modular.dart';
import 'package:time_toggle_buttons/time_toggle_buttons.dart';

class ToggleModular extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (_, args) => TimeToggleButtons()),
      ];
}
