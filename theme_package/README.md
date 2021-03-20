# theme_package

A Flutter package to Manage Themes

## Getting Started

This [package](https://github.com/GitHubStuff/theme_package) is to simplify creating Dark/Light themes and fast switching of themes, as well as response to theme changes at the platform level. It also supports the use of `app flavors`, where builds can be detailed for such variations such as `test, release, beta,...` where key environment varibles (`eg: Urls, file names, one-off colors, etc`) can be set in `main.dart` and retrived anywhere in the app.

### pubspec.yaml

```yaml
dependencies:
  theme_package:
    git:
      url: https://github.com/GitHubStuff/theme_package.git
```

## What is theme_package

There are dark/light modes that can be defined in the `MaterialApp` that usually respond to changes in `Platform Brightness`. However, an app can chose to ignore changes, or override properties (`Color`, `TextStyle`,...). This package helps simplify these changes.

### Key Concept

This package expands the idea of `Theme` beyond dark/light into four(4) types:

```dart
enum ThemeType {
  applicationLight,
  applicationDark,
  platformLight,
  platformDark,
  unknown,
}
```

**Note:** `unknown` is when the app first launches and `ThemeType` hasn't been read from preferences, and will be set when the first widget is rendered.

### Set up: (by example)

VSCODE: `launch.json`

```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "name": "baseline",
      "request": "launch",
      "type": "dart",
      "program": "example/lib/main/main.dart"
    },
    {
      "name": "altered",
      "request": "launch",
      "type": "dart",
      "program": "example/lib/main/main_dev.dart"
    }
  ]
}
```

Two `flavors` are defined `main.dart` and `main_dev.dart`. For each flavor dark and light mode themes are defined, and variables for that specific flavor (often URLs for test, develop, deployment servers). The themes themselves can have additional properties such as one-off TextStyle, Colors, etc.

## How it works

The dart widget tree is set-up as:

* **app_bloc** - Using BLoC design for theme/variable management
  
* **app_theme_with_material_app_widget** - Where `MaterialApp` is wrapped in a *BlocBuilder* change responds to platform/app brightness changes to refresh the widget tree.
  
* **app_scaffold_widget** - Where the `AppScaffold` will set the theme (`applicationLight, applicationDark, platformLight, platformDark`) based on app preference.
  
* **body_widget.dart** - The first rendered State widget.

## Usage

The `example` contained in the package will show how themes are defined, `properties` like theme specific color(s), are tied to a theme. Also, how `variables` for a flavor type can be defined.

## Conclusion

Be kind to each other.
