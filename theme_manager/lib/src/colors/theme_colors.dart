// Copyright 2021, LTMM LLC
// Color-pair for light/dark themes
import 'package:flutter/material.dart';

import '../../theme_manager.dart';

class ThemeColors {
  final Color dark;
  final Color light;
  const ThemeColors({required this.dark, required this.light});
  Color of({required BuildContext context}) => ThemeManager.brightness(context) == Brightness.dark ? dark : light;
  factory ThemeColors.mono({required Color color}) => ThemeColors(dark: color, light: color);
}
