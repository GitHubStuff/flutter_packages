import 'package:flutter/material.dart';
import 'package:theme_manager/theme_manager.dart';

typedef TextCallback = Function(String);
typedef WidgetTypeCallback = Function(WidgetType);

enum WidgetType {
  signin,
  register,
  reset,
}
const String helperText = 'Length 10, 1 upper 1 lower, 1 number, 1 special !@#\$&*~';
const String goodPassword = 'Good Password';
const double boxWidth = 370.0;
const String goodEmail = 'Valid Email';
const String badEmail = 'Incomplete Email';

final ThemeColors borderColors = ThemeColors(
  dark: Colors.white,
  light: Colors.black,
);
