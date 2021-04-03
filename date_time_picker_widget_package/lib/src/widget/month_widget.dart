import 'package:auto_size_text/auto_size_text.dart';
import 'package:date_time_package/date_time_package.dart';
import 'package:date_time_picker_widget_package/src/cubit/date_time_cubit.dart';
import 'package:flutter/material.dart';
import 'package:observing_stateful_widget/observing_stateful_widget.dart';

class MonthWidget extends StatefulWidget {
  final String monthFormat;
  final Size size;
  final double offAxisFraction;
  final DateTimeCubit dateTimeCubit;
  final TextStyle textStyle;

  const MonthWidget(this.dateTimeCubit, {this.monthFormat = 'MMM', this.size = const Size(50, 100), this.offAxisFraction = 0.0, this.textStyle = const TextStyle(fontSize: 400)});

  @override
  _MonthWidget createState() => _MonthWidget();
}

class _MonthWidget extends ObservingStatefulWidget<MonthWidget> {
  double get extent => widget.size.height / 4;
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
          widget.dateTimeCubit.changeMonth(pos);
        } else {}
      });
    });
    final pos = widget.dateTimeCubit.month;
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
      if (index < DateTime.january || index > DateTime.december) return null;
      final monthText = index.asMonth();
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: AutoSizeText(
            '$monthText',
            style: widget.textStyle.copyWith(fontSize: 400),
          ),
        ),
      );
    });
  }
}
