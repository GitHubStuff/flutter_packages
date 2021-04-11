// Copyright 2021, LTMM LLC
// Creates a widget with Hours, Minutes, Seconds, and Merdian Pickers
import 'package:flutter/material.dart';

import '../../date_time_picker_widget_package.dart';

class TimePickerWidget extends StatelessWidget {
  final Size size;
  final DateTimeCubit dateTimeCubit;

  const TimePickerWidget({Key? key, required this.dateTimeCubit, required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final timeWidgetSize = Size(size.width * 0.2258064516, size.height);
    final seperatorSize = Size(size.width * 0.03225806452, size.height);
    return Container(
      margin: const EdgeInsets.all(1.0),
      //decoration: BoxDecoration(border: Border.all(color: Colors.blueAccent)),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          HourWidget(dateTimeCubit, size: timeWidgetSize),
          SeperatorWidget(seperator: ':', size: seperatorSize),
          MinuteWidget(dateTimeCubit, size: timeWidgetSize),
          SeperatorWidget(seperator: ':', size: seperatorSize),
          SecondWidget(dateTimeCubit, size: timeWidgetSize),
          MeridianWidget(dateTimeCubit, size: timeWidgetSize),
        ],
      ),
    );
  }
}
