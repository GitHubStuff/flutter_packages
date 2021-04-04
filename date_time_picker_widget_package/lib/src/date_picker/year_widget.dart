import 'package:flutter/material.dart';
import 'package:observing_stateful_widget/observing_stateful_widget.dart';

import '../cubit/date_time_cubit.dart';
import '../widget/const.dart';
import '../widget/list_wheel_widget.dart';
import '../widget/picker_text_widget.dart';

class YearWidget extends StatefulWidget {
  final Size size;
  final double offAxisFraction;
  final DateTimeCubit dateTimeCubit;
  final TextStyle textStyle;

  const YearWidget(
    this.dateTimeCubit, {
    Key? key,
    required this.size,
    this.offAxisFraction = 0.0,
    this.textStyle = const TextStyle(fontSize: Const.fontSize),
  }) : super(key: key);

  @override
  _YearWidget createState() => _YearWidget();
}

class _YearWidget extends ObservingStatefulWidget<YearWidget> {
  double get extent => widget.size.height / 4;
  final baseYear = 1700;
  final indexLimit = 600;
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
          widget.dateTimeCubit.changeYear(pos + baseYear);
        } else {}
      });
    });
    final pos = widget.dateTimeCubit.year - baseYear;
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
    return ListWheelChildBuilderDelegate(builder: (context, index) {
      if (index < 0 || index > indexLimit) return null;
      final text = '${index + baseYear}';
      return PickerTextWidget(text: text, style: widget.textStyle);
    });
  }
}
