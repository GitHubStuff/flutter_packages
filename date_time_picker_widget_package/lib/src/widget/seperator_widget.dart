import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:observing_stateful_widget/observing_stateful_widget.dart';

import 'const.dart';

class SeperatorWidget extends StatefulWidget {
  final String seperator;
  final Size size;
  final double offAxisFraction;
  final TextStyle textStyle;

  const SeperatorWidget({
    required this.seperator,
    required this.size,
    this.offAxisFraction = 0.0,
    this.textStyle = const TextStyle(fontSize: Const.fontSize, fontWeight: FontWeight.bold),
  });

  @override
  _SeperatorWidget createState() => _SeperatorWidget();
}

class _SeperatorWidget extends ObservingStatefulWidget<SeperatorWidget> {
  double get extent => widget.size.height / 4;
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
      child: _lws(),
    );
  }

  Widget _lws() {
    return ListWheelScrollView.useDelegate(
      childDelegate: _delegate(),
      itemExtent: extent,
      controller: scrollController,
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

  ListWheelChildBuilderDelegate _delegate() {
    return ListWheelChildBuilderDelegate(builder: (context, int index) {
      if (index < 0 || index > 0) return null;

      return Padding(
        padding: Const.seperatorPadding,
        child: Center(
          child: AutoSizeText(
            '${widget.seperator}',
            style: widget.textStyle.copyWith(fontSize: Const.fontSize),
            maxLines: 1,
          ),
        ),
      );
    });
  }
}
