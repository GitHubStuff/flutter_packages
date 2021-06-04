import 'package:flutter/material.dart';

import 'text_keys.dart';

part 'text_theme_definations.dart';

class DefaultThemes {
  static ThemeData get defaultDarkThemeData => ThemeData(
        brightness: Brightness.dark,
        textTheme: TextTheme().merge(_TextThemeDefinations.dark),
        primaryColor: Colors.green[900],
        floatingActionButtonTheme: FloatingActionButtonThemeData().copyWith(
          foregroundColor: Colors.green[50],
          backgroundColor: Colors.green[900],
        ),
        iconTheme: IconThemeData().copyWith(color: Colors.green[300]),
        appBarTheme: AppBarTheme().copyWith(textTheme: TextTheme().merge(_TextThemeDefinations.dark)),
      );
  static ThemeData get defaultLightThemeData => ThemeData(
        brightness: Brightness.light,
        textTheme: TextTheme().merge(_TextThemeDefinations.light),
        primaryColor: Colors.red,
        floatingActionButtonTheme: FloatingActionButtonThemeData().copyWith(),
        iconTheme: IconThemeData().copyWith(color: Colors.blueAccent),
        appBarTheme: AppBarTheme(), //.copyWith(textTheme: TextTheme().merge(_TextThemeDefinations.light)),
      );
}
