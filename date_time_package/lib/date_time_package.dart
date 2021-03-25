library date_time_package;

import 'package:intl/intl.dart';

String get consoleTimeStamp => DateFormat('HH:mm:ss.SSS').format(DateTime.now().toLocal());

enum DateTimeElement {
  year,
  month,
  day,
  hour,
  minute,
  second,
  millisecond,
  microsecond,
}

extension DateTimeExtension on DateTime {
  String asKey() => this.toIso8601String().replaceAll(':', '').replaceAll('.', '').replaceAll('-', '');

  DateTime next(DateTimeElement element, [int delta = 1]) {
    switch (element) {
      case DateTimeElement.year:
        return DateTime(
          this.year + delta,
          this.month,
          this.day,
          this.hour,
          this.minute,
          this.second,
          this.millisecond,
          this.microsecond,
        );

      case DateTimeElement.month:
        final result = DateTime(
          this.year,
          this.month + delta,
          this.day,
          this.hour,
          this.minute,
          this.second,
          this.millisecond,
          this.microsecond,
        );
        return (result.day == this.day) ? result :
          DateTime(
            this.year,
            this.month,
            this.day - 1,
            this.hour,
            this.minute,
            this.second,
            this.millisecond,
            this.microsecond,
          ).next(element, delta);

      case DateTimeElement.day:
        return DateTime(
          this.year,
          this.month,
          this.day + delta,
          this.hour,
          this.minute,
          this.second,
          this.millisecond,
          this.microsecond,
        );
        
      case DateTimeElement.hour:
        return DateTime(
          this.year,
          this.month,
          this.day,
          this.hour + delta,
          this.minute,
          this.second,
          this.millisecond,
          this.microsecond,
        );
        
      case DateTimeElement.minute:
        return DateTime(
          this.year,
          this.month,
          this.day,
          this.hour,
          this.minute + delta,
          this.second,
          this.millisecond,
          this.microsecond,
        );
        
      case DateTimeElement.second:
        return DateTime(
          this.year,
          this.month,
          this.day,
          this.hour,
          this.minute,
          this.second + delta,
          this.millisecond,
          this.microsecond,
        );
        
      case DateTimeElement.microsecond:
        return DateTime(
          this.year,
          this.month,
          this.day,
          this.hour,
          this.minute,
          this.second,
          this.millisecond + delta,
          this.microsecond,
        );
        
      case DateTimeElement.millisecond:
        return DateTime(
          this.year,
          this.month,
          this.day,
          this.hour,
          this.minute,
          this.second,
          this.millisecond,
          this.microsecond + delta,
        );
    }
  }

  DateTime round([DateTimeElement element = DateTimeElement.second]) {
    switch (element) {
      case DateTimeElement.year:
        return DateTime(this.year);
      case DateTimeElement.month:
        return DateTime(this.year, this.month);
      case DateTimeElement.day:
        return DateTime(this.year, this.month, this.day);
      case DateTimeElement.hour:
        return DateTime(this.year, this.month, this.day, this.hour);
      case DateTimeElement.minute:
        return DateTime(this.year, this.month, this.day, this.hour, this.minute);
      case DateTimeElement.second:
        return DateTime(this.year, this.month, this.day, this.hour, this.minute, this.second);
      case DateTimeElement.millisecond:
        return DateTime(this.year, this.month, this.day, this.hour, this.minute, this.second, this.millisecond);
      case DateTimeElement.microsecond:
        return DateTime(this.year, this.month, this.day, this.hour, this.minute, this.second, this.millisecond, this.microsecond);
    }
  }
}
