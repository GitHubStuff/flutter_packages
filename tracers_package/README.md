# tracers_package

Write specialied messages to the console for app development

and

Create/Display TimeMarker()

## Install

```dart
tracers_package:
    git: 
      url: https://github.com/GitHubStuff/flutter_packages.git
      path: tracers_package
```

## Import

```dart
import 'package:tracers_package/tracers.dart';

```

## Getting Started

* Establish logging level

```dart
await Log.setTrace({LogLevel baseLevel});

//Where LogLevel:
enum LogLevel {
  All,
  Mark,
  Trace,
  Verbose,
  Debug,
  Info,
  Warning,
  Error,
  Crash,
  Fix,
  None,
}
```

Each call is of the form 'Log.?(String message, {String tag = ''});

The '?' is:

1. Log.A - All levels
1. Log.M - Mark level
1. Log.T - Trace level
1. Log.V - Verbose level
1. Log.D - Debug level
1. Log.I - Info level
1. Log.F - Fix level
1. Log.W - Warning level
1. Log.E - Error level
1. Log.C - Crash level

## TimeMarker

* To get console display on how long (in seconds.milliseconds) of section of code took to execute.

```dart
final tm = TimeMarker();
  :
  : -- code to run
  :
tm.show([String caption]);
```

Shows the seconds.milliseconds that elapsed between TimeMarker() and .show

#### NOTE: 'caption' is optional

## Special Note

Be Kind To Each Other
