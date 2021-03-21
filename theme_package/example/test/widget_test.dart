// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:template/main/flavor_enum.dart';
import 'package:template/modules/material_app_module/material_app_module.dart';
import 'package:theme_package/theme_package.dart';

//import 'package:example/main.dart';
final _banner = FlavorBanner(name: 'FHCP', color: Colors.purple);

final _darkTheme = ThemeData(
  primaryColor: Colors.brown,
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    foregroundColor: Colors.green,
    backgroundColor: Colors.purple,
  ),
  brightness: Brightness.dark,
);

final _lightTheme = ThemeData(
  primaryColor: Colors.teal,
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    foregroundColor: Colors.pink,
    backgroundColor: Colors.yellow,
  ),
  brightness: Brightness.light,
);

final Map<String, dynamic> _variables = {
  FlavorEnum.bulbColor.key: ColorsForTheme(
    dark: Colors.red,
    light: Colors.cyan,
  ),
  FlavorEnum.fabColor.key: ColorsForTheme(
    dark: Color(0xff9ccc65),
    light: Color(0xfff0cef8),
  )
};

final _flavorConfig = FlavorConfig(
  flavorBanner: _banner,
  darkThemeData: _darkTheme,
  lightThemeData: _lightTheme,
  constants: _variables,
  startingLogLevel: LogLevel.All,
);

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    final TestWidgetsFlutterBinding testBinding = tester.binding;
    testBinding.window.platformBrightnessTestValue = Brightness.light;

    await tester.pumpWidget(ModularApp(module: MaterialAppModule(flavorConfig: _flavorConfig)));

/*
    /// Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    /// Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    /// Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
    */
  });
}
