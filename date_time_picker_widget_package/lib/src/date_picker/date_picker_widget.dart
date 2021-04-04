// Copyright 2021, LTMM LLC.
// Creates widget with year, month, day pickers
import 'package:date_time_package/date_time_package.dart';
import 'package:flutter/material.dart';

import '../../date_time_picker_widget_package.dart';

class DatePickerWidget extends StatelessWidget {
  final Size size;
  final DateTimeCubit dateTimeCubit;
  final List<DateTimeElement> ordering;
  const DatePickerWidget({
    Key? key,
    required this.size,
    required this.dateTimeCubit,
    this.ordering = const [DateTimeElement.day, DateTimeElement.month, DateTimeElement.year],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final yearWidgetSize = Size(size.width / 3.6, size.height);
    final monthWidgetSize = Size(size.width / 2.1, size.height);
    final dayWidgetSize = Size(size.width / 4.6, size.height);
    final List<Widget> children = [];
    for (DateTimeElement element in ordering) {
      switch (element) {
        case DateTimeElement.year:
          children.add(YearWidget(dateTimeCubit, size: yearWidgetSize));
          break;
        case DateTimeElement.month:
          children.add(MonthWidget(
            dateTimeCubit,
            size: monthWidgetSize,
            monthFormat: 'MMMM',
          ));
          break;
        case DateTimeElement.day:
          children.add(DayWidget(dateTimeCubit, size: dayWidgetSize));
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
      decoration: BoxDecoration(border: Border.all(color: Colors.blueAccent)),
      child: Row(mainAxisSize: MainAxisSize.min, children: children),
    );
  }
}
