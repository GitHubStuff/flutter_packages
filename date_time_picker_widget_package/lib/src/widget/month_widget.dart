import 'package:date_time_package/date_time_package.dart';
import 'package:date_time_picker_widget_package/src/cubit/date_time_cubit.dart';
import 'package:flutter/material.dart';
import 'package:observing_stateful_widget/observing_stateful_widget.dart';

class MonthWidget extends StatefulWidget {
  final String monthFormat;
  final double height;
  final double offAxisFraction;
  final DateTimeCubit dateTimeCubit;

  const MonthWidget(this.dateTimeCubit, {this.monthFormat = 'MMM', this.height = 100.0, this.offAxisFraction = 0.0});

  @override
  _MonthWidget createState() => _MonthWidget();
}

class _MonthWidget extends ObservingStatefulWidget<MonthWidget> {
  double get extent => widget.height / 4;
  final scrollController = FixedExtentScrollController();
  final baseMonth = 1;

  @override
  void initState() {
    super.initState();
  }

  @override
  void afterFirstLayout(BuildContext buildContext) {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      scrollController.addListener(() {
        debugPrint('Scrolling');
      });
      scrollController.position.isScrollingNotifier.addListener(() {
        if (!scrollController.position.isScrollingNotifier.value) {
          print('scroll is stopped');
          final pos = scrollController.selectedItem;
          widget.dateTimeCubit.changeMonth(pos + baseMonth);
          print('Stopped $pos');
        } else {
          print('scroll is started');
        }
      });
    });
    final pos = widget.dateTimeCubit.month - baseMonth;
    scrollController.jumpToItem(pos);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.height * 1.25,
      height: widget.height,
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
        debugPrint('$index');
      },
    );
  }

  ListWheelChildBuilderDelegate _delegate() {
    return ListWheelChildBuilderDelegate(builder: (context, int index) {
      if (index < DateTime.january || index > DateTime.december) return null;
      final z = index.asMonth();
      return Center(
        child: Text(
          '$z',
          style: TextStyle(fontSize: 0.8 * extent, color: (index % 2 == 0) ? Colors.green : Colors.blue),
        ),
      );
    });
  }
}
