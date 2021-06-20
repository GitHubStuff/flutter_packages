// Copyright 2021, LTMM LLC
import 'package:flutter/material.dart';
import 'package:flutter_extras/flutter_extras.dart';

import '/source/cubit/date_time_cubit.dart';
import '../constants.dart' as K;
import '../widgets/list_wheel.dart';
import '../widgets/picker_text.dart';

abstract class TemplateWidget extends StatefulWidget {
  final Size size;
  final double offAxisFraction;
  final DateTimeElement timeElement;

  TemplateWidget({
    Key? key,
    required this.timeElement,
    required this.size,
    this.offAxisFraction = 0.0,
  }) : super(key: key);

  @override
  _TemplateWidget createState() => _TemplateWidget();
}

class _TemplateWidget extends ObservingStatefulWidget<TemplateWidget> {
  double get extent => widget.size.height * K.scrollWheelExtent;
  final scrollController = FixedExtentScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void afterFirstLayout(BuildContext buildContext) {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      scrollController.addListener(() {
        //debugPrint('Scrolling');
      });
      scrollController.position.isScrollingNotifier.addListener(() {
        if (!scrollController.position.isScrollingNotifier.value) {
          final pos = scrollController.selectedItem;
          DateTimeCubit.cubit.change(widget.timeElement, to: pos);
        } else {}
      });
    });
    final pos = DateTimeCubit.cubit.fetch(widget.timeElement);
    scrollController.jumpToItem(pos + K.minutesSecondsInfiniteWheelOffset);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size.width,
      height: widget.size.height,
      child: _listWheelWidget(),
    );
  }

  Widget _listWheelWidget() => ListWheel(
        scrollController: scrollController,
        extent: extent,
        delegate: _delegate(),
        offAxisFraction: widget.offAxisFraction,
      );

  ListWheelChildBuilderDelegate _delegate() {
    return ListWheelChildBuilderDelegate(builder: (context, int index) {
      if (index < 0) return null;
      final text = (index % 60).toString().padLeft(2, '0');
      return PickerText(text: text);
    });
  }
}
