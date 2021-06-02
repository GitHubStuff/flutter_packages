# theme_manager

Manages an app's ability to change themes (light/dark/system).

## Getting Started

Modify **main** to be async and call **ThemeManager.setup()**

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ThemeManager.setup();   <---- VERY IMPORANT
  runApp(MyApp());
}
```

### NOTE

There are default **darkTheme**, **lightTheme**, and **themeIcons** but it is best practice to use your own. The colors themes for the app are defined by calling:

```dart
ThemeManager(ThemeData? darkTheme, 
             ThemeData? lightTheme,
             ThemeIcons? themeIcons,
             Map<String,ThemeColors>? colorMap);
```

where:

- themeIcons is an abstract class the defines widgets for applicationDark, applicationLight, platformDark, platformLight. These widget can be used when display dialogs that show the platform state
- colorMap allows for storing theme colors by 'key' for lookup within the app.

**ThemeCubit** is extension of Cubit and is used to get, set, and report theme state.

The **ThemeManager** should be the parent widget at the top of the tree (usually parent of MaterialApp) where theme changes are defined:

Example:

```dart
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeCubitState>(
      bloc: ThemeManager.themeCubit,
      builder: (_, state) {
        ThemeMode themeMode = ThemeManager.themeMode; // system, light, dark
        if (state is UpdateThemeMode) {
          themeMode = state.themeMode;
        }
        return MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeManager.lightTheme,
          darkTheme: ThemeManager.darkTheme,
          themeMode: themeMode,
          home: MyHomePage(title: 'Flutter Demo Home Page'),
        );
      },
    );
  }
}
```

## ThemeState

There are four(4) states for an app that can be in effect.

```dart
enum ThemeState {
  applicationDark,
  applicationLight,
  platformDark,
  platformLight,
}
```

- applicationDark : bypasses the platform brightness and enforces DarkTheme for the app
- applicationLight :  bypasses the platform brightness and enforces LightTheme for the app
- plaformDark : queries the platform brightness and determed the system level theme enforces DarkTheme
- plaformDark : queries the platform brightness and determed the system level theme enforces LightTheme

## Changing Theme

At any point to change the theme:


```dart

ThemeManager.themeMode = THemeMode.dark;

ThemeManager.themeMode = THemeMode.light;

ThemeManager.themeMode = THemeMode.system;

// Or get the current theme:

ThemeMode currentMode = ThemeManager.themeMode;

```

The theme *WILL be preserved across application launches*. ThemeMode.system, the theme used will be based on Platform.brightness.

## Class Helpers

- await setup() : ***MUST BE CALLED AT APP LAUNCH***
- get darkTheme : returns the defined darkTheme
- get lightTheme : returns the defined lightTheme
- get themeCubit : returns the Cubit used for theme state {for BlocBuilder<ThemeCubit, ThemeState> to wrap theme state changes.
- get themeIcons : returns the class that defines widgets the represent brightness state
- defaultThemeColors(ThemeColors theColors, {required String forKey}) : sets an inital color {will not override any color for the 'forKey'}
- addThemeColors(ThemeColors colors, {required String forKey, bool allowOverwrite = false}) : Add a color to the list and throw an error if already there unless allowOverwrite = true
- Brightness brightness(BuildContext context) - returned the Brightness of the app
- Color color(String key, {required BuildContext context}) - returns a color based on ThemeMode or throws error if it doesn't exist
- Widget themeModeIcon(BuildContext context) - returns the widget based in the mode {application light/dark, platform light/dark}
- ThemeState themeState(BuildContext context) : returns ThemeState value {see enum ThemeState}

### TextKey Extension

**TextKey** is enum{see below} the provides a key from the typography of an app. This is used instead of a String to help prevent typo's in string constants, and ensure all 'switch' cases are covered.

```dart
 Color color = {TextKey}.getColor({required Brightness forBrightness});  //Light or Dark theme color

 TextStyle ts = {TextKey}.asTextStyle({required Brightness forBrightness});  //TextStyle

 TextStyle ts = {TextKey}.asTextStyleOf({required BuildContext contex, required ThemeMode themeMode}); 

 double fontSize = {TextKey}.getFontSize;
```

### ThemeMode Extension

```dart
  /// Gets the theme mode as a brightness, for TyemeMode.system the context != null or an error is thrown
  Brightness b = {ThemeMode}.asBrightness({required BuildContext context});

  String text = {ThemeMode}.asString();  //returns "dark", "light", or "system"

  //Returns a widget {most likely a picture} for
  // ThemeMode.dark
  // ThemeMode.light
  // ThemeMode.system --> this returns a widget for "platfromLight" or "platformDark" {see 'ThemeIcons'}
  Widget widget = {ThemeMode}.getIcon({required BuildContext context});
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