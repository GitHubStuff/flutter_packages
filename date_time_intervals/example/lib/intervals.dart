import 'package:date_time_intervals/date_time_intervals.dart';
import 'package:flutter_extras/flutter_extras.dart';

DateTimeIntervals behind23Hours3minutes10second() {
  final eventDateTime = DateTime.now().toUtc().subtract(Duration(
        hours: 23,
        minutes: 3,
        seconds: 10,
      ));
  return DateTimeIntervals.fromCurrentDateTime(
    eventDateTime: eventDateTime,
    setOfCalendarItems: {
      DateTimeElement.year,
      DateTimeElement.month,
      DateTimeElement.day,
      DateTimeElement.hour,
      DateTimeElement.minute,
      DateTimeElement.second,
    },
  );
}

DateTimeIntervals ahead1Month() {
  final eventDateTime = DateTime.now().toUtc().add(Duration(days: 725, hours: 12, minutes: 44, seconds: 59));
  return DateTimeIntervals.fromCurrentDateTime(
    eventDateTime: eventDateTime,
    setOfCalendarItems: {
      DateTimeElement.year,
      DateTimeElement.month,
      DateTimeElement.day,
      DateTimeElement.hour,
      DateTimeElement.minute,
      DateTimeElement.second,
    },
  );
}

DateTimeIntervals ahead22Hours5minutes15second() {
  final eventDateTime = DateTime.now().toUtc().add(Duration(
        hours: 22,
        minutes: 5,
        seconds: 15,
      ));
  return DateTimeIntervals.fromCurrentDateTime(
    eventDateTime: eventDateTime,
    setOfCalendarItems: {
      DateTimeElement.year,
      DateTimeElement.month,
      DateTimeElement.day,
      DateTimeElement.hour,
      DateTimeElement.minute,
      DateTimeElement.second,
    },
  );
}

DateTimeIntervals ahead26Hours3minutes() {
  final eventDateTime = DateTime.now().toUtc().add(Duration(hours: 26, minutes: 3));
  return DateTimeIntervals(
    endEvent: eventDateTime,
    startEvent: DateTime.now().toUtc(),
    setOfCalendarItems: {
      DateTimeElement.year,
      DateTimeElement.month,
      DateTimeElement.day,
      DateTimeElement.hour,
      DateTimeElement.minute,
      DateTimeElement.second,
    },
  );
}

DateTimeIntervals ahead1year26Hours3minutes() {
  final eventDateTime = DateTime.now().toUtc().add(Duration(days: 399, hours: 26, minutes: 3, seconds: 4));
  return DateTimeIntervals(
    endEvent: eventDateTime,
    startEvent: DateTime.now().toUtc(),
    setOfCalendarItems: {
      DateTimeElement.year,
      DateTimeElement.month,
      DateTimeElement.day,
      DateTimeElement.hour,
      DateTimeElement.minute,
      DateTimeElement.second,
    },
  );
}

DateTimeIntervals ahead16hr14min11se() {
  final eventDateTime = DateTime.now().toUtc().add(Duration(hours: 16, minutes: 14, seconds: 11));
  return DateTimeIntervals(
    endEvent: eventDateTime,
    startEvent: DateTime.now().toUtc(),
    setOfCalendarItems: {
      DateTimeElement.year,
      DateTimeElement.month,
      DateTimeElement.day,
      DateTimeElement.hour,
      DateTimeElement.minute,
      DateTimeElement.second,
    },
  );
}
