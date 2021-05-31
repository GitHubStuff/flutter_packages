//Copyright 2021, LTMM LLC
import 'package:flutter/material.dart';
import 'package:flutter_extras/flutter_extras.dart';

import '../constants.dart' as K;
import '../cubit/date_time_cubit.dart';
import '../widgets/list_wheel.dart';
import '../widgets/picker_text.dart';

class YearWidget extends StatefulWidget {
  final Size size;
  final double offAxisFraction;

  YearWidget({
    Key? key,
    required this.size,
    this.offAxisFraction = 0.0,
  }) : super(key: key);

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
          DateTimeCubit.cubit.changeYear(pos + K.baseYear);
        } else {}
      });
    });
    final pos = DateTimeCubit.cubit.year - K.baseYear;
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

  Widget _listWheelWidget() => ListWheel(
        scrollController: scrollController,
        extent: extent,
        delegate: _delegate(),
        offAxisFraction: widget.offAxisFraction,
      );

  ListWheelChildBuilderDelegate _delegate() {
    return ListWheelChildBuilderDelegate(builder: (context, index) {
      if (index < 0 || index > K.yearLimit) return null;
      final text = '${index + K.baseYear}';
      return PickerText(text: text);
    });
  }
}
