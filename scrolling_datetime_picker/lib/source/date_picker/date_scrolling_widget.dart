// Copyright 2021, LTMM LLC.
// Creates widget with year, month, day scroll pickers
import 'package:flutter/material.dart';
import 'package:flutter_extras/flutter_extras.dart';

import '../constants.dart' as K;
import 'day_widget.dart';
import 'month_widget.dart';
import 'year_widget.dart';

class DateScrollingWidget extends StatelessWidget {
  final Size size;

  final List<DateTimeElement> ordering;
  final String monthDisplayFormat;
  DateScrollingWidget({
    Key? key,
    this.size = K.minimalPickerSize,
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
          children.add(YearWidget(size: yearWidgetSize));
          break;
        case DateTimeElement.month:
          children.add(MonthWidget(
            size: monthWidgetSize,
            monthFormat: monthDisplayFormat,
          ));
          break;
        case DateTimeElement.day:
          children.add(DayWidget(
            size: dayWidgetSize,
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
