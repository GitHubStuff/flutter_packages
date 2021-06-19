import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_extras/flutter_extras.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:persisted_cache/persisted_cache.dart';
import 'package:theme_manager/theme_manager.dart';

import 'modular/app_module.dart';
import 'modular/theme_and_material_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Report flutter_bloc information to the console
  Bloc.observer = SimpleBlocObserver();

  /// Enable theme changes/monitoring by creating a 'hive' object to persist information
  await ThemeManager.setup();

  final cache = PersistedCache<String>(cacheId: 'pig');
  int i = 0;
  Future.delayed(Duration(seconds: 3), () {
    Timer.periodic(Duration(microseconds: 1), (timer) {
      debugPrint('$i -- adding');
      cache.value = '$i';
      var _ = cache.value;
      if (++i == 15) {
        timer.cancel();
        final List<String> items = cache.cachedItems();
        debugPrint('Saved? $items');
      }
    });
  });

  // final restart = PersistedCache<String>(cacheId: 'pig');
  // final List<String> restared = restart.cachedItems();
  // debugPrint('Data:$restared');

  runApp(ModularApp(
    module: AppModule(),
    child: ThemeAndMaterialWidget(),
  ));
}
