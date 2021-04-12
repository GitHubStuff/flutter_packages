// Copyright 2021, LTMM LLC
import 'package:date_time_package/date_time_package.dart';
import 'package:flutter/material.dart';
import 'package:observing_stateful_widget/observing_stateful_widget.dart';

import '../constants/constants.dart' as K;
import '../cubit/date_time_cubit.dart';
import '../widget/list_wheel_widget.dart';
import '../widget/picker_text_widget.dart';

abstract class MinuteOrSecondTemplateWidget extends StatefulWidget {
  final Size size;
  final double offAxisFraction;
  final DateTimeCubit dateTimeCubit;
  late final TextStyle textStyle;
  final DateTimeElement timeElement;
  final Color textColor;

  MinuteOrSecondTemplateWidget(
    this.dateTimeCubit, {
    Key? key,
    required this.timeElement,
    required this.size,
    required this.textColor,
    this.offAxisFraction = 0.0,
    TextStyle? textStyle,
  })  : this.textStyle = (textStyle ?? TextStyle()).copyWith(fontSize: K.fontSize),
        super(key: key);

  @override
  _MinutesOrSecondTemplateWidget createState() => _MinutesOrSecondTemplateWidget();
}

class _MinutesOrSecondTemplateWidget extends ObservingStatefulWidget<MinuteOrSecondTemplateWidget> {
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
          widget.dateTimeCubit.change(widget.timeElement, to: pos);
        } else {}
      });
    });
    final pos = widget.dateTimeCubit.fetch(widget.timeElement);
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

  Widget _listWheelWidget() => ListWheelWidget(
        scrollController: scrollController,
        extent: extent,
        delegate: _delegate(),
        offAxisFraction: widget.offAxisFraction,
      );

  ListWheelChildBuilderDelegate _delegate() {
    return ListWheelChildBuilderDelegate(builder: (context, int index) {
      if (index < 0) return null;
      final text = (index % 60).toString().padLeft(2, '0');
      return PickerTextWidget(
        text: text,
        style: widget.textStyle,
        textColor: widget.textColor,
      );
    });
  }
}
