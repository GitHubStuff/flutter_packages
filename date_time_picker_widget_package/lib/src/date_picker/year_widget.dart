//Copyright 2021, LTMM LLC
import 'package:flutter/material.dart';
import 'package:observing_stateful_widget/observing_stateful_widget.dart';

import '../cubit/date_time_cubit.dart';
import '../widget/list_wheel_widget.dart';
import '../widget/picker_text_widget.dart';
import '../constants/constants.dart' as K;

class YearWidget extends StatefulWidget {
  final Size size;
  final double offAxisFraction;
  final DateTimeCubit dateTimeCubit;
  late final TextStyle textStyle;

  YearWidget(
    this.dateTimeCubit, {
    Key? key,
    required this.size,
    this.offAxisFraction = 0.0,
    TextStyle? textStyle,
  })  : this.textStyle = (textStyle ?? TextStyle()).copyWith(fontSize: K.fontSize),
        super(key: key);

  @override
  _YearWidget createState() => _YearWidget();
}

class _YearWidget extends ObservingStatefulWidget<YearWidget> {
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
          widget.dateTimeCubit.changeYear(pos + K.baseYear);
        } else {}
      });
    });
    final pos = widget.dateTimeCubit.year - K.baseYear;
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
      if (index < 0 || index > K.yearLimit) return null;
      final text = '${index + K.baseYear}';
      return PickerTextWidget(text: text, style: widget.textStyle);
    });
  }
}
