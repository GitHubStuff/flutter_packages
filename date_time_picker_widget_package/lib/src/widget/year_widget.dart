import 'package:auto_size_text/auto_size_text.dart';
import 'package:date_time_picker_widget_package/src/cubit/date_time_cubit.dart';
import 'package:flutter/material.dart';
import 'package:observing_stateful_widget/observing_stateful_widget.dart';

class YearWidget extends StatefulWidget {
  final Size size;
  final double offAxisFraction;
  final DateTimeCubit dateTimeCubit;
  final TextStyle textStyle;

  const YearWidget(
    this.dateTimeCubit, {
    this.size = const Size(50, 100),
    this.offAxisFraction = 0.0,
    this.textStyle = const TextStyle(fontSize: 400),
  });

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
    return ListWheelChildBuilderDelegate(builder: (context, index) {
      if (index < 0 || index > indexLimit) return null;
      final style = widget.textStyle.copyWith(fontSize: 400);
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: AutoSizeText(
            '${index + baseYear}',
            style: style,
          ),
        ),
      );
    });
  }
}
