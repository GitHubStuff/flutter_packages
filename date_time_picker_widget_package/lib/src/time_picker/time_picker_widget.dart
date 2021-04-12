// Copyright 2021, LTMM LLC
// Creates a widget with Hours, Minutes, Seconds, and Merdian Pickers
import 'package:flutter/material.dart';

import '../../date_time_picker_widget_package.dart';
import '../constants/constants.dart' as K;

class TimePickerWidget extends StatelessWidget {
  final Size size;
  final DateTimeCubit dateTimeCubit;

  TimePickerWidget({Key? key, required this.dateTimeCubit, this.size = K.minimalPickerSize})
      : assert(
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
          HourWidget(dateTimeCubit, size: timeWidgetSize),
          SeperatorWidget(seperator: K.timeWidgetSeperator, size: seperatorSize),
          MinuteWidget(dateTimeCubit, size: timeWidgetSize),
          SeperatorWidget(seperator: K.timeWidgetSeperator, size: seperatorSize),
          SecondWidget(dateTimeCubit, size: timeWidgetSize),
          MeridianWidget(dateTimeCubit, size: timeWidgetSize),
        ],
      ),
    );
  }
}
