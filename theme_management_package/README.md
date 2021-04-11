# theme_management_package

Manages an app's ability to change themes (light/dark/system).

## Getting Started

Modify **main** to be async and call **ThemeCubit.setup()**

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ThemeCubit.setup();
  runApp(MyApp());
}
```

Either through Dependency-Injection, as a global constant, or other state managment (BLoC, Riverpod, etc) create a singleton of:

```dart
themeCubit = ThemeCubit({ThemeData? darkTheme, ThemeData? lightTheme, ThemeIcons? themeIcons})
```

### NOTE

There are default **darkTheme**, **lightTheme**, and **themeIcons** but it is best practice to use your own

**ThemeCubit** is extension for Cubit and is used to get, set, and report theme state.

The **ThemeCubit** should be the parent of whatever widget defines the app's theme {usually **MaterialApp()**}

Example:

```dart
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeCubitState>(
      bloc: themeCubit,
      builder: (_, state) {
        ThemeMode themeMode = themeCubit.themeMode;
        if (state is UpdateThemeMode) {
          themeMode = state.themeMode;
        }
        return MaterialApp(
          title: 'Flutter Demo',
          theme: themeCubit.lightTheme,
          darkTheme: themeCubit.darkTheme,
          themeMode: themeMode,
          home: MyHomePage(title: 'Flutter Demo Home Page'),
        );
      },
    );
  }
}
```

## Changing Theme

At any point to change the theme call:

```dart
themeCubit.setThemeMode(ThemeMode.dark);

or

themeCubit.setThemeMode(ThemeMode.light);

or

themeCubit.setThemeMode(ThemeMode.system);
```

## Helpers

Collection of methods and classes to help with theme identification, management, and settings.

### Class CustomColor

A repository of colors that can be access by a **key** to return a color for theme mode (light/dark/system).

```dart
// The BuildContext is needed to return colors for ThemeMode.system
Color c = CustomColor.by({required String key, required ThemeMode themeMode, required BuildContext? using});

Color c = CustomColor.of(String key, {required Brightness brightness});

Color c = CustomColor.ofPlatformBrightness({required String key, required BuildContext context});

CustomColor.add({required String key, required Color dark, required Color light});

CustomColor.addMono({required Color color, required String key});
```

### String Extension

Convert string to ThemeMode or throws CannotReadThemeMode if the string can't be parsed\

```dart
  {string}.asThemeMode()   // transforms strings "dark", "light", "system"
```

### TextKey Extension

**TextKey** is enum{see below} the provides a key from the typography of an up. This is used instead of a String to help prevent typo's in string constants, and ensure all 'switch' cases are covered.

```dart
 Color color = {TextKey}.getColor({required Brightness forBrightness});  //Light or Dark theme color

 TextStyle ts = {TextKey}.asTextStyle({required Brightness forBrightness});  //TextStyle

 TextStyle ts = {TextKey}.asTextStyleOf({required BuildContext contex, required ThemeMode themeMode}); 

 double fontSize = {TextKey}.getFontSize;
```

### ThemeMode Extension

```dart
  /// Gets the theme mode as a brightness, for TyemeMode.system the context != null or an error is thrown
  Brightness b = {ThemeMode}.asBrightness({required BuildContext? context});

  String text = {ThemeMode}.asString();  //returns "dark", "light", or "system"

  //Returns a widget {most likely a picture} for
  // ThemeMode.dark
  // ThemeMode.light
  // ThemeMode.system --> this returns a widget for "platfromLight" or "platformDark" {see 'ThemeIcons'}
  Widget widget = {ThemeMode}.getIcon({required BuildContext context, required ThemeIcons usingThemeIcons});
```

### MISC

#### ThemeIcons

An abstract class used to template the creation of Widgets for ThemeModes, the widgets can be used to display the ThemeMode state of the application.

```dart
abstract class ThemeIcons {
  final Widget applicationDark;
  final Widget applicationLight;
  final Widget platformDark;
  final Widget platformLight;
  final Widget platform;

  const ThemeIcons({
    required this.applicationDark,
    required this.applicationLight,
    required this.platformDark,
    required this.platformLight,
    required this.platform,
  });
}
``` 

#### TextKeys

There is an enum TextKeys that enumerates the common tags for text styles, and Maps for size, and color:

```dart
enum TextKeys {
  headline1,
  headline2,
  headline3,
  headline4,
  headline5,
  headline6,
  subtitle1,
  subtitle2,
  bodyText1,
  bodyText2,
  caption,
  button,
  overline,
}

// Font sizes
Map<TextKeys, double> textSizeMap = {
  TextKeys.headline1: 96.0,
  TextKeys.headline2: 60.0,
  TextKeys.headline3: 48.0,
  TextKeys.headline4: 32.0,
  TextKeys.headline5: 24.0,
  TextKeys.headline6: 20.0,
  TextKeys.subtitle1: 16.0,
  TextKeys.subtitle2: 14.0,
  TextKeys.bodyText1: 16.0,
  TextKeys.bodyText2: 15.0,
  TextKeys.button: 14.0,
  TextKeys.caption: 12.0,
  TextKeys.overline: 10.0,
};

Map<TextKeys, Color> textColorLightMode = {
  TextKeys.headline1: Colors.black,
  TextKeys.headline2: Colors.black,
  TextKeys.headline3: Colors.black,
  TextKeys.headline4: Colors.black,
  TextKeys.headline5: Colors.black,
  TextKeys.headline6: Colors.black,
  TextKeys.subtitle1: Colors.black,
  TextKeys.subtitle2: Colors.black,
  TextKeys.bodyText1: Colors.black,
  TextKeys.bodyText2: Colors.black,
  TextKeys.button: Colors.black,
  TextKeys.caption: Colors.black,
  TextKeys.overline: Colors.black,
};

Map<TextKeys, Color> textColorDarkMode = {
  TextKeys.headline1: Colors.yellow[300]!,
  TextKeys.headline2: Colors.yellow[300]!,
  TextKeys.headline3: Colors.yellow[300]!,
  TextKeys.headline4: Colors.yellow[300]!,
  TextKeys.headline5: Colors.yellow[300]!,
  TextKeys.headline6: Colors.yellow[300]!,
  TextKeys.subtitle1: Colors.yellow[300]!,
  TextKeys.subtitle2: Colors.yellow[300]!,
  TextKeys.bodyText1: Colors.yellow[300]!,
  TextKeys.bodyText2: Colors.yellow[300]!,
  TextKeys.button: Colors.yellow[300]!,
  TextKeys.caption: Colors.yellow[300]!,
  TextKeys.overline: Colors.yellow[300]!,
};
```

that can be used (or changed) in creating light/dark custom TextThemes.

#### Dialog

There is a US-English only alert style dialog that can change the theme of the application.

```dart
class SetThemeDialog {
  static void show({required BuildContext context, required ThemeCubit themeCubit})
```

## SPECIAL NOTE

Be kind to each other.