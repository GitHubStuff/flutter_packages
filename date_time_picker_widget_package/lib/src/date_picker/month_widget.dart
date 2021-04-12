// Copyright 2021, LTMM LLC
import 'package:date_time_package/date_time_package.dart';
import 'package:flutter/material.dart';
import 'package:observing_stateful_widget/observing_stateful_widget.dart';

import '../constants/constants.dart' as K;
import '../cubit/date_time_cubit.dart';
import '../widget/list_wheel_widget.dart';
import '../widget/picker_text_widget.dart';

class MonthWidget extends StatefulWidget {
  final String monthFormat;
  final Size size;
  final double offAxisFraction;
  final DateTimeCubit dateTimeCubit;
  late final TextStyle textStyle;
  final Color textColor;

  MonthWidget(
    this.dateTimeCubit, {
    Key? key,
    this.monthFormat = K.monthDisplayFormat,
    required this.size,
    required this.textColor,
    this.offAxisFraction = 0.0,
    TextStyle? textStyle,
  })  : this.textStyle = (textStyle ?? TextStyle()).copyWith(fontSize: K.fontSize),
        super(key: key);

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
          widget.dateTimeCubit.changeMonth((pos % K.monthsInYear) == 0 ? K.monthsInYear : (pos % K.monthsInYear));
        } else {}
      });
    });
    final pos = widget.dateTimeCubit.month;
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

  Widget _listWheelWidget() => ListWheelWidget(
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
      return PickerTextWidget(text: monthText, style: widget.textStyle, textColor: widget.textColor,);
    });
  }
}
