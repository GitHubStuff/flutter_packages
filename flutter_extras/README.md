# flutter_extras

A collection of useable extensions and classes that are useful helpers in most projects.

## Getting Started

```dart
- showConfirmDialog, showInfoDialog - platform dialogs for Confirm and Info.

- class SimpleBlocObserver - when using 'flutter_bloc' package this can be "attached" to report BLoC events to the console.

- mixin BlurOverlay - overlayDismiss, showTextDialog, showTextSpinner, showWidgetDialog, showWidgetSpinner allow calls to showDialogs with backgrounds (aka barrier) that obscure the content beneath. The Spinner variants include a platform specific spinner.

- extension ContextExtension on BuildContext - provides information about the current context, "textTheme", "primaryTextTheme", "colorScheme", "appTheme", "isKeyboardOpen", "platformBrightness", "height", "width"

- enum DateTimeElement - enum for year, month, day, hour, minute, second, millisecond, microsecond that provides pseudo type safe defination when working with time elements.

- extension DateTimeExtension on DateTime - short-cut helpers when working with DateTime. There are several simplier helpers, the biggest feature is the ***"next(DateTimeElement, [int delta = 1])"***, where a delta can be allowed to any element and the correct DateTime is returned. {Better then just adding Duration because it handles, months, and years}

- extension ImageExtension on Image - rightRotation, upRotation, bottomRotation, leftRotation

- extension DurationExtension on Duration - add(Duration amount), sub(Duration amount) add/subtract a duration

- extension IntDateTimeExtension on int - Helpers that can use return text for numbers that represent a month (eg 1.asMonth() => 'Jan'), or an int as meridian (eg 14.asMeridian() => 'pm', 10.asMerdian() => 'am'). Any values outside ranges (month on works for 1..12, time 0..23) throws an exception.

- class LanguageDto - Encapsulates localized strings into a single manager class for lookup of localized strings.

- abstract class ObservingStatefulWidget<T extends StatefulWidget> extends State<T> with WidgetsBindingObserver - Used as the suffix for StatefulWidget (eg ...extends State<X> use ...extends ObservingStatefulWidget<X>. This adds addition features and callbacks: ***afterFirstLayout, reportTextScaleFactor, didChangePlatformBrightness, didChageAppLifecycleState, didChangeTextScaleFactor***

- class SpinnerWidget - Platform specific spinner with trailing Widget, or SpinnerWidget.text('text') for spinner followed by Text widget with given string

- extension StringExtensions on String - aids in convert strings to other property types:
1. bool isEmail
1. static String compaseDateTimeItems(Set<DateTimeItems> items)
1. Set<DateTimeElements> get elements
1. static String get uniqueKey
1. String scrub([String items = ' \t\n', String replace = ''])
1. DateTime get sqlite
1. asThemeMode() => converts 'system','light','dark' case insensitive

- extension WidgetExtensions on Widget - removed(bool state): removes a widget from the tree (replaces the widget as SizedBox(height:1). hide(bool state): changes opacitity on the widget to hide it.

- class WidgetSize extends StatefulWidget - wrap a widget in this class to get callbacks if/when the widget changes size.
```

## Final Note

Be kind to each other
