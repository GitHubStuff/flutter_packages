// Copyright 2021, LTMM LLC
import 'package:flutter/material.dart';
import 'package:flutter_extras/flutter_extras.dart';

import '../constants.dart' as K;
import '../cubit/date_time_cubit.dart';
import '../widgets/list_wheel.dart';
import '../widgets/picker_text.dart';

class MonthWidget extends StatefulWidget {
  final String monthFormat;
  final Size size;
  final double offAxisFraction;

  MonthWidget({
    Key? key,
    this.monthFormat = K.monthDisplayFormat,
    required this.size,
    this.offAxisFraction = 0.0,
  }) : super(key: key);

  @override
  _MonthWidget createState() => _MonthWidget();
}

class _MonthWidget extends ObservingStatefulWidget<MonthWidget> {
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
          DateTimeCubit.cubit.changeMonth((pos % K.monthsInYear) == 0 ? K.monthsInYear : (pos % K.monthsInYear));
        } else {}
      });
    });
    final pos = DateTimeCubit.cubit.month;
    scrollController.jumpToItem(pos + K.monthInfiniteWheelOffset);
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
      if (index < DateTime.january) return null;
      int offset = (index % K.monthsInYear) == 0 ? K.monthsInYear : (index % K.monthsInYear);
      final monthText = offset.asMonth(format: widget.monthFormat);
      return PickerText(text: monthText);
    });
  }
}
