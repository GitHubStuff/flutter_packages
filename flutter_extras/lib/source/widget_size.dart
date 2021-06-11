// Copyright 2021, LTMM LLC.
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

/// Wrap a widget in 'WidgetSize' and get call backs when the widget is built or size changes
class WidgetSize extends StatefulWidget {
  final Widget child;
  final Function onChange;

  const WidgetSize({
    Key? key,
    required this.child,
    required this.onChange,
  }) : super(key: key);

  @override
  _WidgetSizeState createState() => _WidgetSizeState();
}

class _WidgetSizeState extends State<WidgetSize> {
  final _widgetKey = GlobalKey();
  var oldSize;

  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance!.addPostFrameCallback(_postFrameCallback);
    return Container(
      key: _widgetKey,
      child: widget.child,
    );
  }

  void _postFrameCallback(_) {
    var context = _widgetKey.currentContext;
    if (context == null) return;

    var newSize = context.size;
    if (oldSize == newSize) return;

    oldSize = newSize;
    widget.onChange(newSize);
  }
}
