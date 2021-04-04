// Copyright 2021, LTMM LLC
// Single source for ListWheelScroll view used by the individual pickers

import 'package:flutter/material.dart';

class ListWheelWidget extends StatefulWidget {
  late final FixedExtentScrollController scrollController;
  late final double offAxisFraction;
  late final ListWheelChildDelegate delegate;
  late final double extent;

  ListWheelWidget({
    Key? key,
    required this.delegate,
    required this.extent,
    required this.scrollController,
    required this.offAxisFraction,
  }) : super(key: key);

  @override
  _ListWheelWidget createState() => _ListWheelWidget();
}

class _ListWheelWidget extends State<ListWheelWidget> {
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
      magnification: 1.1,
      overAndUnderCenterOpacity: 0.4,
      onSelectedItemChanged: (index) {
        //debugPrint('$index');
      },
    );
  }
}
