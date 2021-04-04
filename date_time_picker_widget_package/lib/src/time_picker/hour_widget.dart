import 'package:date_time_package/date_time_package.dart';
import 'package:flutter/material.dart';
import 'package:observing_stateful_widget/observing_stateful_widget.dart';

import '../cubit/date_time_cubit.dart';
import '../widget/list_wheel_widget.dart';
import '../widget/picker_text_widget.dart';

class HourWidget extends StatefulWidget {
  final Size size;
  final double offAxisFraction;
  final DateTimeCubit dateTimeCubit;
  final TextStyle textStyle;

  const HourWidget(
    this.dateTimeCubit, {
    Key? key,
    required this.size,
    this.offAxisFraction = 0.0,
    this.textStyle = const TextStyle(fontSize: 400),
  }) : super(key: key);

  @override
  _HourWidget createState() => _HourWidget();
}

class _HourWidget extends ObservingStatefulWidget<HourWidget> {
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
          widget.dateTimeCubit.change(DateTimeElement.hour, to: (pos % 12) == 0 ? 12 : (pos % 12));
        } else {}
      });
    });
    final pos = widget.dateTimeCubit.hour12;
    scrollController.jumpToItem(pos + 360);
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
      int offset = (hourIndex % 12) == 0 ? 12 : (hourIndex % 12);
      final text = offset.toString().padLeft(2, '0');
      return PickerTextWidget(text: text, style: widget.textStyle);
    });
  }
}
