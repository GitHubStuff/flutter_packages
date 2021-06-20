// Copyright 2021, LTMM LLC
// Creates a seperator used but TimePickerWidget
import 'package:flutter/material.dart';
import 'package:flutter_extras/flutter_extras.dart';

import '../../source/widgets/list_wheel.dart';
import '../../source/widgets/picker_text.dart';
import '../constants.dart' as K;

class SeperatorWidget extends StatefulWidget {
  final String seperator;
  final Size size;
  final double offAxisFraction;

  const SeperatorWidget({
    required this.seperator,
    required this.size,
    this.offAxisFraction = 0.0,
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
      child: ListWheel(
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
      return PickerText(text: '${widget.seperator}');
    });
  }
}
