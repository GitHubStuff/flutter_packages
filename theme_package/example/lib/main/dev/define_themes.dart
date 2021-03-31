part of 'main.dart';

/// Create a [dark] theme
final _darkThemeData = DefaultDarkThemeData.copyWith(
  primaryColor: Colors.brown,
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    foregroundColor: Colors.green,
    backgroundColor: Colors.purple,
  ),
);

/// Create a [light] theme
final _lightThemeData = DefaultLightThemeData.copyWith(
  primaryColor: Colors.teal,
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    foregroundColor: Colors.pink,
    backgroundColor: Colors.yellow,
  ),
);