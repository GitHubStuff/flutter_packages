// Copyright 2021, LTMM LLC
import 'package:flutter/material.dart';

import '../constants.dart' as K;

/// Source for ListWheelScroll view used by the individual pickers
class ListWheel extends StatefulWidget {
  late final FixedExtentScrollController scrollController;
  late final double offAxisFraction;
  late final ListWheelChildDelegate delegate;
  late final double extent;

  ListWheel({
    Key? key,
    required this.delegate,
    required this.extent,
    required this.scrollController,
    required this.offAxisFraction,
  }) : super(key: key);

  @override
  _ListWheel createState() => _ListWheel();
}

class _ListWheel extends State<ListWheel> {
  @override
  Widget build(BuildContext context) {
    return ListWheelScrollView.useDelegate(
      childDelegate: widget.delegate,
      itemExtent: widget.extent,
      controller: widget.scrollController,
      offAxisFraction: widget.offAxisFraction,
      physics: FixedExtentScrollPhysics(),
      perspective: 0.0001,
      useMagnifier: true,
      magnification: K.scrollWidgetMagnification,
      overAndUnderCenterOpacity: K.overUnderOpacity,
      onSelectedItemChanged: (index) {
        //debugPrint('$index');
      },
    );
  }
}
