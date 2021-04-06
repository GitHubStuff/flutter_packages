library observing_stateful_widget;

import 'package:flutter/material.dart';

abstract class ObservingStatefulWidget<T extends StatefulWidget> extends State<T> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    final instance = WidgetsBinding.instance;
    instance?.addPostFrameCallback((_) => afterFirstLayout(context));
    instance?.addObserver(this);
    reportTextScaleFactor(instance?.window.textScaleFactor);
  }

  // Called after layout
  @mustCallSuper
  void afterFirstLayout(BuildContext context);

  void reportTextScaleFactor(double? textScaleFactor);

  @mustCallSuper
  void didChangePlatformBrightness();

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {}

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
