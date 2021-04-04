import 'package:flutter/material.dart';

import '../../date_time_picker_widget_package.dart';

class DatePickerWidget extends StatelessWidget {
  final Size size;
  final DateTimeCubit dateTimeCubit;
  const DatePickerWidget({Key? key, required this.size, required this.dateTimeCubit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final yearWidgetSize = Size(size.width / 3.6, size.height);
    final monthWidgetSize = Size(size.width / 2.1, size.height);
    final dayWidgetSize = Size(size.width / 4.6, size.height);

    return Container(
      margin: const EdgeInsets.all(1.0),
      decoration: BoxDecoration(border: Border.all(color: Colors.blueAccent)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          MonthWidget(
            dateTimeCubit,
            size: monthWidgetSize,
            monthFormat: 'MMMM',
          ),
          DayWidget(dateTimeCubit, size: dayWidgetSize),
          YearWidget(dateTimeCubit, size: yearWidgetSize),
        ],
      ),
    );
  }
}
