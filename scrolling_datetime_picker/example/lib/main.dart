import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_extras/flutter_extras.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:theme_manager/theme_manager.dart';

import 'modular/app_module.dart';
import 'modular/theme_and_material_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Report flutter_bloc information to the console
  Bloc.observer = SimpleBlocObserver();

  /// Enable theme changes/monitoring by creating a 'hive' object to persist information
  await ThemeManager.setup();

  runApp(ModularApp(
    module: AppModule(),
    child: ThemeAndMaterialWidget(),
  ));
}
