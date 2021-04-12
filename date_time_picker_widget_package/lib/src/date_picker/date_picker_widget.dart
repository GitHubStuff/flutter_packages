// Copyright 2021, LTMM LLC.
// Creates widget with year, month, day scroll pickers
import 'package:date_time_package/date_time_package.dart';
import 'package:flutter/material.dart';

import '../../date_time_picker_widget_package.dart';
import '../constants/constants.dart' as K;

class DatePickerWidget extends StatelessWidget {
  final Size size;

  final DateTimeCubit dateTimeCubit;
  final List<DateTimeElement> ordering;
  final String monthDisplayFormat;
  final Color pickerTextColor;
  DatePickerWidget({
    Key? key,
    this.size = K.minimalPickerSize,
    required this.dateTimeCubit,
    required this.pickerTextColor,
    this.monthDisplayFormat = K.monthDisplayFormat,
    this.ordering = const [DateTimeElement.day, DateTimeElement.month, DateTimeElement.year],
  })  : assert(
          size.width >= K.minimalPickerSize.width && size.height >= K.minimalPickerSize.height,
          'Minimal Size ${K.minimalPickerSize}',
        ),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final yearWidgetSize = Size(size.width / K.yearWidgetFactor, size.height);
    final monthWidgetSize = Size(size.width / K.monthWidgetFactor, size.height);
    final dayWidgetSize = Size(size.width / K.dayWidgetFactor, size.height);
    final List<Widget> children = [];
    for (DateTimeElement element in ordering) {
      switch (element) {
        case DateTimeElement.year:
          children.add(YearWidget(
            dateTimeCubit,
            size: yearWidgetSize,
            textColor: pickerTextColor,
          ));
          break;
        case DateTimeElement.month:
          children.add(MonthWidget(
            dateTimeCubit,
            textColor: pickerTextColor,
            size: monthWidgetSize,
            monthFormat: monthDisplayFormat,
          ));
          break;
        case DateTimeElement.day:
          children.add(DayWidget(
            dateTimeCubit,
            size: dayWidgetSize,
            textColor: pickerTextColor,
          ));
          break;
        default:
          throw Exception('Cannot have $element in date picker');
      }
      if (!ordering.contains(DateTimeElement.year)) throw Exception('Missing Year Widget');
      if (!ordering.contains(DateTimeElement.month)) throw Exception('Missing Month Widget');
      if (!ordering.contains(DateTimeElement.day)) throw Exception('Missing Day Widget');
    }

    return Container(
      margin: const EdgeInsets.all(1.0),
      // decoration: BoxDecoration(border: Border.all(color: Colors.blueAccent)),
      child: Row(mainAxisSize: MainAxisSize.max, children: children),
    );
  }
}
