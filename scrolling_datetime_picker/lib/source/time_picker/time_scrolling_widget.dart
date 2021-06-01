// Copyright 2021, LTMM LLC
// Creates a widget with Hours, Minutes, Seconds, and Merdian Pickers
import 'package:flutter/material.dart';

import '../constants.dart' as K;
import 'hour_widget.dart';
import 'meridian_widget.dart';
import 'minute_widget.dart';
import 'second_widget.dart';
import 'seperator_widget.dart';

class TimeScrollingWidget extends StatelessWidget {
  final Size size;

  TimeScrollingWidget({
    Key? key,
    this.size = K.minimalPickerSize,
  })  : assert(
          size.width >= K.minimalPickerSize.width && size.height >= K.minimalPickerSize.height,
          'Minimal Size ${K.minimalPickerSize}',
        ),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final timeWidgetSize = Size(size.width * K.timeWidgetWidthFactor, size.height);
    final seperatorSize = Size(size.width * K.timeSeperatorWidthFactor, size.height);
    return Container(
      margin: const EdgeInsets.all(1.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          HourWidget(size: timeWidgetSize),
          SeperatorWidget(seperator: K.timeWidgetSeperator, size: seperatorSize),
          MinuteWidget(size: timeWidgetSize),
          SeperatorWidget(seperator: K.timeWidgetSeperator, size: seperatorSize),
          SecondWidget(size: timeWidgetSize),
          MeridianWidget(size: timeWidgetSize),
        ],
      ),
    );
  }
}
