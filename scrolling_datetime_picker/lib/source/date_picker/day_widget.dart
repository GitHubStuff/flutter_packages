//Copyright 2021, LTMM LLC
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_extras/flutter_extras.dart';
import 'package:intl/intl.dart';

import '../constants.dart' as K;
import '../cubit/date_time_cubit.dart';
import '../widgets/list_wheel.dart';
import '../widgets/picker_text.dart';

class DayWidget extends StatefulWidget {
  final String dayFormat;
  final Size size;
  final double offAxisFraction;

  DayWidget({
    Key? key,
    this.dayFormat = K.dayDisplayFormat,
    required this.size,
    this.offAxisFraction = 0.0,
  }) : super(key: key);

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
      scrollController.position.isScrollingNotifier.addListener(() {
        if (!scrollController.position.isScrollingNotifier.value) {
          final pos = scrollController.selectedItem;
          final daysInMonth = DateTimeCubit.cubit.daysInTheMonth;
          int offset = (pos % daysInMonth) == 0 ? daysInMonth : (pos % daysInMonth);
          DateTimeCubit.cubit.changeDay(offset);
        } else {}
      });
    });
    final pos = DateTimeCubit.cubit.day;
    scrollController.jumpToItem(pos);
    DateTimeCubit.cubit.setScrollController(scrollController);
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
        bloc: DateTimeCubit.cubit,
        builder: (cntxt, dateTimeState) {
          return _listWheelWidget();
        });
  }

  Widget _listWheelWidget() => ListWheel(
        scrollController: scrollController,
        extent: extent,
        delegate: _delegate(),
        offAxisFraction: widget.offAxisFraction,
      );

  ListWheelChildBuilderDelegate _delegate() {
    return ListWheelChildBuilderDelegate(builder: (context, int dayIndex) {
      if (dayIndex < 1) return null;
      final daysInMonth = DateTimeCubit.cubit.daysInTheMonth;
      int offset = (dayIndex % daysInMonth) == 0 ? daysInMonth : (dayIndex % daysInMonth);
      final dayText = DateFormat(widget.dayFormat).format(DateTime(2000, DateTime.january, offset));
      return PickerText(text: dayText);
    });
  }
}
