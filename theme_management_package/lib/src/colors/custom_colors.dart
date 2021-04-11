// Copyright 2021, LTMM LLC
// Manages [Custom Colors] that can be retrieved by [key] with correct [Theme color]
import 'package:flutter/material.dart';

import '../app_exceptions.dart';
import '../extensions/theme_mode_extensions.dart';

class CustomColor {
  final Color dark;
  final Color light;
  const CustomColor({required this.dark, required this.light});
  Color of(Brightness brightness) => (Brightness.dark == brightness) ? dark : light;
}

class CustomColorManager {
  static Map<String, CustomColor> _repository = {};

  static Color by({required String key, required ThemeMode themeMode, required BuildContext? using}) => of(
        key,
        brightness: themeMode.asBrightness(context: using),
      );

  static Color of(String key, {required Brightness brightness}) {
    if (_repository[key.toLowerCase()] == null) throw UnknownColor('Cannot find color key:$key');
    return (_repository[key]!).of(brightness);
  }

  static Color ofPlatformBrightness({required String key, required BuildContext context}) => of(
        key,
        brightness: MediaQuery.of(context).platformBrightness,
      );

  static void add({required String key, required Color dark, required Color light}) => _repository[key.toLowerCase()] = CustomColor(
        dark: dark,
        light: light,
      );

  static void addMono({required Color color, required String key}) => add(key: key, dark: color, light: color);
}
