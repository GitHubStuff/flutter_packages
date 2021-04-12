// Copyright 2021, LTMM LLC
import 'package:date_time_package/date_time_package.dart';
import 'package:flutter/material.dart';
import 'package:observing_stateful_widget/observing_stateful_widget.dart';

import '../constants/constants.dart' as K;
import '../cubit/date_time_cubit.dart';
import '../widget/list_wheel_widget.dart';
import '../widget/picker_text_widget.dart';

class HourWidget extends StatefulWidget {
  final Size size;
  final double offAxisFraction;
  final DateTimeCubit dateTimeCubit;
  late final TextStyle textStyle;

  HourWidget(
    this.dateTimeCubit, {
    Key? key,
    required this.size,
    this.offAxisFraction = 0.0,
    TextStyle? textStyle,
  })  : this.textStyle = (textStyle ?? TextStyle()).copyWith(fontSize: K.fontSize),
        super(key: key);

  @override
  _HourWidget createState() => _HourWidget();
}

class _HourWidget extends ObservingStatefulWidget<HourWidget> {
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
          widget.dateTimeCubit.change(DateTimeElement.hour, to: (pos % K.noon) == K.midnight ? K.noon : (pos % K.noon));
        } else {}
      });
    });
    final pos = widget.dateTimeCubit.hour12;
    scrollController.jumpToItem(pos + K.hourMinuteInfiniteWheelOffset);
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
    return ListWheelChildBuilderDelegate(builder: (context, int hourIndex) {
      if (hourIndex < 1) return null;
      int offset = (hourIndex % K.noonOrMidnight) == K.midnight ? K.noon : (hourIndex % K.noonOrMidnight);
      final text = offset.toString().padLeft(2, '0');
      return PickerTextWidget(text: text, style: widget.textStyle);
    });
  }
}
