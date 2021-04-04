import 'package:date_time_package/date_time_package.dart';
import 'package:flutter/material.dart';
import 'package:observing_stateful_widget/observing_stateful_widget.dart';

import '../cubit/date_time_cubit.dart';
import '../widget/list_wheel_widget.dart';
import '../widget/picker_text_widget.dart';

class SixtyWidget extends StatefulWidget {
  final Size size;
  final double offAxisFraction;
  final DateTimeCubit dateTimeCubit;
  final TextStyle textStyle;
  final DateTimeElement timeElement;

  const SixtyWidget(
    this.dateTimeCubit, {
    Key? key,
    required this.timeElement,
    this.size = const Size(50, 100),
    this.offAxisFraction = 0.0,
    this.textStyle = const TextStyle(fontSize: 400),
  }) : super(key: key);

  @override
  _SixtyWidget createState() => _SixtyWidget();
}

class _SixtyWidget extends ObservingStatefulWidget<SixtyWidget> {
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
      if (index < DateTime.january || index > DateTime.december) return null;
      final monthText = index.asMonth();
      return PickerTextWidget(text: monthText, style: widget.textStyle);
    });
  }
}