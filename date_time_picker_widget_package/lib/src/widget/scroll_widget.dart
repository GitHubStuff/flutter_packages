import 'dart:math';

import 'package:date_time_picker_widget_package/src/cubit/date_time_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:observing_stateful_widget/observing_stateful_widget.dart';

class ScrollWidget extends StatefulWidget {
  final double height;
  final double offAxisFraction;

  const ScrollWidget({this.height = 100.0, this.offAxisFraction = 0.0});

  @override
  _ScrollWidget createState() => _ScrollWidget();
}

class _ScrollWidget extends ObservingStatefulWidget<ScrollWidget> {
  final scrollController = FixedExtentScrollController();
  double get extent => widget.height / 4;
  int indexLimit = 50;
  late DateTimeCubit dateTimeCubit;

  @override
  void initState() {
    super.initState();
    dateTimeCubit = Modular.get<DateTimeCubit>();
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
          print('Stopped $pos');
        } else {
          print('scroll is started');
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: widget.height * 1.25,
          height: widget.height,
          child: _lws(),
        ),
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                indexLimit = 40;
                final pos = scrollController.selectedItem;
                scrollController.jumpToItem(-1);
                scrollController.jumpToItem(min(pos, indexLimit));
              });
            },
            child: Text('PUSH ME'),
          ),
        ),
      ],
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
    return ListWheelChildBuilderDelegate(builder: (context, index) {
      if (index < 0 || index > indexLimit) return null;
      return Center(
        child: Text(
          'Index $index',
          style: TextStyle(fontSize: 0.8 * extent, color: (index % 2 == 0) ? Colors.green : Colors.blue),
        ),
      );
    });
  }
}
