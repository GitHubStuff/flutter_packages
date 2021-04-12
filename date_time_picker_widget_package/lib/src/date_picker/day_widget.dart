//Copyright 2021, LTMM LLC
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:observing_stateful_widget/observing_stateful_widget.dart';

import '../constants/constants.dart' as K;
import '../cubit/date_time_cubit.dart';
import '../widget/list_wheel_widget.dart';
import '../widget/picker_text_widget.dart';

class DayWidget extends StatefulWidget {
  final String dayFormat;
  final Size size;
  final double offAxisFraction;
  final DateTimeCubit dateTimeCubit;
  late final TextStyle textStyle;

  DayWidget(
    this.dateTimeCubit, {
    Key? key,
    this.dayFormat = K.dayDisplayFormat,
    required this.size,
    this.offAxisFraction = 0.0,
    TextStyle? textStyle,
  })  : this.textStyle = (textStyle ?? TextStyle()).copyWith(fontSize: K.fontSize),
        super(key: key);

  @override
  _DayWidget createState() => _DayWidget();
}

class _DayWidget extends ObservingStatefulWidget<DayWidget> {
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
          final daysInMonth = widget.dateTimeCubit.daysInTheMonth;
          int offset = (pos % daysInMonth) == 0 ? daysInMonth : (pos % daysInMonth);
          widget.dateTimeCubit.changeDay(offset);
        } else {}
      });
    });
    final pos = widget.dateTimeCubit.day;
    scrollController.jumpToItem(pos);
    widget.dateTimeCubit.setScrollController(scrollController);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size.width,
      height: widget.size.height,
      child: _cubitBuilder(),
    );
  }

  Widget _cubitBuilder() {
    return BlocBuilder<DateTimeCubit, DateTimeState>(
        bloc: widget.dateTimeCubit,
        builder: (cntxt, dateTimeState) {
          return _listWheelWidget();
        });
  }

  Widget _listWheelWidget() => ListWheelWidget(
        scrollController: scrollController,
        extent: extent,
        delegate: _delegate(),
        offAxisFraction: widget.offAxisFraction,
      );

  ListWheelChildBuilderDelegate _delegate() {
    return ListWheelChildBuilderDelegate(builder: (context, int dayIndex) {
      if (dayIndex < 1) return null;
      final daysInMonth = widget.dateTimeCubit.daysInTheMonth;
      int offset = (dayIndex % daysInMonth) == 0 ? daysInMonth : (dayIndex % daysInMonth);
      final dayText = DateFormat(widget.dayFormat).format(DateTime(2000, DateTime.january, offset));
      return PickerTextWidget(text: dayText, style: widget.textStyle);
    });
  }
}
