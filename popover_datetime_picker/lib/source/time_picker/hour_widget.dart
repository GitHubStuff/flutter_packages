// Copyright 2021, LTMM LLC
import 'package:flutter/material.dart';
import 'package:flutter_extras/flutter_extras.dart';

import '../../source/cubit/date_time_cubit.dart';
import '../constants.dart' as K;
import '../widgets/list_wheel.dart';
import '../widgets/picker_text.dart';

class HourWidget extends StatefulWidget {
  final Size size;
  final double offAxisFraction;

  HourWidget({
    Key? key,
    required this.size,
    this.offAxisFraction = 0.0,
    TextStyle? textStyle,
  }) : super(key: key);

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
    final DateTimeCubit dateTimeCubit = DateTimeCubit.cubit;
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      scrollController.addListener(() {
        //debugPrint('Scrolling');
      });
      scrollController.position.isScrollingNotifier.addListener(() {
        if (!scrollController.position.isScrollingNotifier.value) {
          final pos = scrollController.selectedItem;
          dateTimeCubit.change(DateTimeElement.hour, to: (pos % K.noon) == K.midnight ? K.noon : (pos % K.noon));
        } else {}
      });
    });
    final pos = dateTimeCubit.hour12;
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

  Widget _listWheelWidget() => ListWheel(
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
      return PickerText(text: text);
    });
  }
}
