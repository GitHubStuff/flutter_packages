import 'package:date_time_picker_widget_package/src/cubit/date_time_cubit.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:observing_stateful_widget/observing_stateful_widget.dart';

class DayWidget extends StatefulWidget {
  final String dayFormat;
  final Size size;
  final double offAxisFraction;
  final DateTimeCubit dateTimeCubit;

  const DayWidget(this.dateTimeCubit, {this.dayFormat = 'dd', this.size = const Size(50, 100), this.offAxisFraction = 0.0});

  @override
  _DayWidget createState() => _DayWidget();
}

class _DayWidget extends ObservingStatefulWidget<DayWidget> {
  double get extent => widget.size.height / 4;
  final scrollController = FixedExtentScrollController();
  final baseDay = 1;

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
          widget.dateTimeCubit.changeMonth(pos + baseDay);
        } else {}
      });
    });
    final pos = widget.dateTimeCubit.day;
    scrollController.jumpToItem(pos);
  }

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
      if (index < 1 || index > widget.dateTimeCubit.daysInTheMonth) return null;
      final dayText = DateFormat(widget.dayFormat).format(DateTime(2000, 1, index));
      return Center(
        child: Text(
          '$dayText',
          style: TextStyle(fontSize: 0.8 * extent, color: (index % 2 == 0) ? Colors.green : Colors.blue),
        ),
      );
    });
  }
}
