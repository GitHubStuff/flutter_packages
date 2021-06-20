// Copyright 2021, LTMM LLC
// Creates a widget with Hours, Minutes, Seconds{optional}, and Merdian Pickers
import 'package:flutter/material.dart';

import '../constants.dart' as K;
import 'hour_widget.dart';
import 'meridian_widget.dart';
import 'minute_widget.dart';
import 'second_widget.dart';
import 'seperator_widget.dart';

class TimeScrollingWidget extends StatelessWidget {
  final Size size;
  final bool includeSeconds;

  TimeScrollingWidget({
    Key? key,
    this.size = K.minimalPickerSize,
    required this.includeSeconds,
  })  : assert(
          size.width >= K.minimalPickerSize.width && size.height >= K.minimalPickerSize.height,
          'Minimal Size ${K.minimalPickerSize}',
        ),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(1.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: elements(),
      ),
    );
  }

  /// The elements of a row (hour widget) (colon) (minute widget) [(colon) (second widget)] (meridian)
  List<Widget> elements() {
    final timeWidgetSize = Size(size.width * K.timeWidgetWidthFactor, size.height);
    final seperatorSize = Size(size.width * K.timeSeperatorWidthFactor, size.height);
    final List<Widget> result = [
      Spacer(),
      HourWidget(size: timeWidgetSize),
      Spacer(),
      SeperatorWidget(seperator: K.timeWidgetSeperator, size: seperatorSize),
      Spacer(),
      MinuteWidget(size: timeWidgetSize),
    ];

    if (includeSeconds) {
      result.addAll([
        SeperatorWidget(seperator: K.timeWidgetSeperator, size: seperatorSize),
        Spacer(),
        SecondWidget(size: timeWidgetSize),
      ]);
    }
    result.addAll([
      Spacer(),
      MeridianWidget(size: timeWidgetSize),
      Spacer(),
    ]);

    return result;
  }
}
