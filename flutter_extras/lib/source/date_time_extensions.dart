import 'package:intl/intl.dart';

import '../flutter_extras.dart';

DateTime? _baseTime;

extension DateTimeExtension on DateTime {
  static DateTime unique() {
    DateTime newTime = DateTime.now().toUtc();
    if (_baseTime != null && newTime.isAtSameMomentAs(_baseTime!)) {
      _baseTime = _baseTime!.add(Duration(microseconds: 1));
      return _baseTime!;
    }
    _baseTime = newTime;
    return _baseTime!;
  }

  static String asSqlite([DateTime? dateTime]) => (dateTime ?? DateTime.now()).sqlite;

  static int daysInMonth(int month, {required int year}) {
    if (!(month >= DateTime.january && month <= DateTime.december)) throw ArgumentError('Months 1-12 .. value passed $month');
    return (isLeapYear(year) && month == 2) ? 29 : [0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31][month];
  }

  static String get timeStamp => DateFormat('HH:mm:ss.SSS').format(DateTime.now().toLocal());

  static bool isLeapYear(int year) => (year % 400 == 0)
      ? true
      : (year % 100 == 0)
          ? false
          : (year % 4 == 0);

  String get sqlite => this.toUtc().toIso8601String();

  String asKey() => this.toIso8601String().replaceAll(':', '').replaceAll('.', '').replaceAll('-', '');

  String monthText([String fmt = 'MMM']) => DateFormat(fmt).format(this);

  int get daysInTheMonth => daysInMonth(this.month, year: this.year);

  String shortTime([String fmt = 'h:mm a']) => DateFormat(fmt).format(this);
  String shortDate([String fmt = 'dd-MMM-yyyy']) => DateFormat(fmt).format(this);

  int get hour12 => (this.hour == 0)
      ? 12
      : (this.hour < 13)
          ? this.hour
          : this.hour - 12;

  DateTime update(DateTimeElement element, {required int to}) {
    return DateTime(
      (element == DateTimeElement.year ? to : this.year),
      (element == DateTimeElement.month ? to : this.month),
      (element == DateTimeElement.day ? to : this.day),
      (element == DateTimeElement.hour ? to : this.hour),
      (element == DateTimeElement.minute ? to : this.minute),
      (element == DateTimeElement.second ? to : this.second),
      (element == DateTimeElement.millisecond ? to : this.millisecond),
      (element == DateTimeElement.microsecond ? to : this.microsecond),
    );
  }

  DateTime next(DateTimeElement element, [int delta = 1]) {
    switch (element) {
      case DateTimeElement.year:
        final result = DateTime(
          this.year + delta,
          this.month,
          this.day,
          this.hour,
          this.minute,
          this.second,
          this.millisecond,
          this.microsecond,
        );
        return (result.month == this.month)
            ? result
            : DateTime(
                this.year,
                this.month,
                this.day - 1,
                this.hour,
                this.minute,
                this.second,
                this.millisecond,
                this.microsecond,
              ).next(element, delta);

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
        return (result.day == this.day)
            ? result
            : DateTime(
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
