# observing_stateful_widget

Extenstion for StatefulWidget that adds 'afterFirstLayout' callback, callbacks when text scale changes, brightness changes, and state changes

## Getting Started

Typical extension of a StatefulWidget:

```dart
class _MyStatefulWidget extends State<MyStateFullWidget> {
  ...
}
```

Refactor to use ObservingStateWidget:

```dart
class _MyStatefulWidget extends ObservingStatefulWidget<_yStatefulWidget> {

  @override
  void afterFirstLayout(BuildContext context) {}

  @override
  void reportTextScaleFactor(double? textScaleFactor) {
    debugPrint('🎈 TextScaleFactor: $textScaleFactor');
  }

  @override
  void didChangePlatformBrightness() {
    super.didChangePlatformBrightness();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {}

  @override
  void didChangeTextScaleFactor() {
    final textScalceFactor = WidgetsBinding.instance?.window.textScaleFactor;
    reportTextScaleFactor(textScalceFactor);
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

    :
    :
  @override
  Widget build(BuildContext context) {
    // TODO: Scaffold or other widget
  }
}
```

See **'example/main.dart'** for an example of ObservingStatefulWidget

## Conclusion

Be kind to each other
