// Copyright 2021, LTMM LLC
// Creates a seperator used but TimePickerWidget
import 'package:flutter/material.dart';
import 'package:observing_stateful_widget/observing_stateful_widget.dart';

import '../../src/widget/list_wheel_widget.dart';
import '../../src/widget/picker_text_widget.dart';
import '../constants/constants.dart' as K;

class SeperatorWidget extends StatefulWidget {
  final String seperator;
  final Size size;
  final double offAxisFraction;
  final TextStyle textStyle;

  const SeperatorWidget({
    required this.seperator,
    required this.size,
    this.offAxisFraction = 0.0,
    this.textStyle = const TextStyle(fontSize: K.fontSize, fontWeight: FontWeight.bold),
  });

  @override
  _SeperatorWidget createState() => _SeperatorWidget();
}

class _SeperatorWidget extends ObservingStatefulWidget<SeperatorWidget> {
  double get extent => widget.size.height * K.scrollWheelExtent;
  final scrollController = FixedExtentScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void afterFirstLayout(BuildContext buildContext) {}

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size.width,
      height: widget.size.height,
      child: ListWheelWidget(
        scrollController: scrollController,
        extent: extent,
        offAxisFraction: widget.offAxisFraction,
        delegate: _delegate(),
      ),
    );
  }

  ListWheelChildBuilderDelegate _delegate() {
    return ListWheelChildBuilderDelegate(builder: (context, int index) {
      if (index < 0 || index > 0) return null;
      return PickerTextWidget(text: '${widget.seperator}', style: widget.textStyle);
    });
  }
}
