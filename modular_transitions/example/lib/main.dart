import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:theme_manager/theme_manager.dart';

import 'modular/app_module.dart';
import 'modular/theme_and_material_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ThemeManager.setup();
  runApp(ModularApp(
    module: AppModule(),
    child: ThemeAndMaterialWidget(),
  ));
}
