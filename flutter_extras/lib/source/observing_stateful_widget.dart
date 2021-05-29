import 'package:flutter/material.dart';

abstract class ObservingStatefulWidget<T extends StatefulWidget> extends State<T> with WidgetsBindingObserver {
  @mustCallSuper
  @override
  void initState() {
    super.initState();
    final instance = WidgetsBinding.instance;
    instance?.addPostFrameCallback((_) => afterFirstLayout(context));
    instance?.addObserver(this);
    reportTextScaleFactor(instance?.window.textScaleFactor);
  }

  void afterFirstLayout(BuildContext context) {}

  void reportTextScaleFactor(double? textScaleFactor) {}

  void didChangePlatformBrightness() {}

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {}

  @mustCallSuper
  @override
  void didChangeTextScaleFactor() {
    final textScalceFactor = WidgetsBinding.instance?.window.textScaleFactor;
    reportTextScaleFactor(textScalceFactor);
  }

  @mustCallSuper
  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }
}
