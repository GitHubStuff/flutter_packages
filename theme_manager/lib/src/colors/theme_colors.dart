// Copyright 2021, LTMM LLC
// Color-pair for light/dark themes
import 'package:flutter/material.dart';

class ThemeColors {
  final Color dark;
  final Color light;
  const ThemeColors({required this.dark, required this.light});
  Color of(Brightness brightness) => (Brightness.dark == brightness) ? dark : light;
  factory ThemeColors.mono({required Color color}) => ThemeColors(dark: color, light: color);
}
