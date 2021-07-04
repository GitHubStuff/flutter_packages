// Copyright 2021 LTMM, LLC. All rights reserved.
import 'package:flutter/material.dart';
import 'package:flutter_extras/flutter_extras.dart';
import 'package:intl/intl.dart';

import 'calendar_items.dart';

const int _HOURS_PER_DAY = 24;
const int _MINUTES_PER_DAY = 1440;
const int _MINUTES_PER_HOUR = 60;
const int _MONTHS_PER_YEAR = 12;
const int _SECONDS_PER_DAY = 86400;
const int _SECONDS_PER_HOUR = 3600;
const int _SECONDS_PER_MINUTE = 60;

class DateTimeIntervals {
  // NOTE: null means wasn't requested
  int? _years;
  int? _months;
  int? _days;
  int? _hours;
  int? _minutes;
  int? _seconds;
  CalendarDirection _direction = CalendarDirection.untilEnd;

  /// Constructor
  DateTimeIntervals({
    Set<DateTimeElement?> setOfCalendarItems = SetOfAllCalendarItems,
    @required DateTime? startEvent,
    DateTime? endEvent,
  }) {
    if (setOfCalendarItems.isEmpty) throw FlutterError('Cannot have empty/null setOfCalendarItems');
    if (startEvent == null) throw FlutterError('Cannot have null startEvent');
    DateTime startingDateTime = _timeWrapper(startEvent);
    DateTime endingDateTime = _timeWrapper(endEvent ?? DateTime.now());
    _direction = startingDateTime.compareTo(endingDateTime) > 0 ? CalendarDirection.sinceEnd : CalendarDirection.untilEnd;
    if (_direction == CalendarDirection.sinceEnd) {
      startingDateTime = _timeWrapper(endingDateTime);
      endingDateTime = _timeWrapper(startEvent);
    }
    _direction = CalendarDirection.between;

    if (setOfCalendarItems.contains(DateTimeElement.year) || setOfCalendarItems.contains(DateTimeElement.month)) {
      _approximateInterval(setOfCalendarItems, startingDateTime, endingDateTime);
    } else {
      _exactInterval(setOfCalendarItems, startingDateTime, endingDateTime);
    }
  }

  /// Factory
  factory DateTimeIntervals.fromCurrentDateTime({
    Set<DateTimeElement?> setOfCalendarItems = SetOfAllCalendarItems,
    @required DateTime? eventDateTime,
  }) {
    if (setOfCalendarItems.isEmpty) throw FlutterError('Cannot have empty/null setOfCalendarItems');
    if (eventDateTime == null) throw FlutterError('Cannot have null eventDateTime');
    final endDateTime = DateTime.now().toUtc();
    DateTimeIntervals dateTimeIntervals = DateTimeIntervals(
      setOfCalendarItems: setOfCalendarItems,
      startEvent: eventDateTime.toUtc(),
      endEvent: endDateTime,
    );
    final duration = endDateTime.difference(eventDateTime);
    dateTimeIntervals._direction = (duration.isNegative) ? CalendarDirection.untilEnd : CalendarDirection.sinceEnd;
    return dateTimeIntervals;
  }

  /// Properties
  int? get days => _days;
  CalendarDirection get direction => _direction;
  int? get hours => _hours;
  int? get minutes => _minutes;
  int? get months => _months;
  int? get seconds => _seconds;
  int? get years => _years;

  String countdownBar() {
    String result = '';
    final yr = _pad(_years);
    final mh = _pad(_months, yr.isEmpty);
    final dy = _pad(_days, mh.isEmpty);
    final hr = _pad(_hours, dy.isEmpty);
    final mn = _pad(_minutes, hr.isEmpty);
    final sc = _pad(_seconds, mn.isEmpty);

    result = yr + ((yr.isNotEmpty) ? '-' : '');
    result += mh + ((mh.isNotEmpty) ? '-' : '');
    result += dy + ((dy.isNotEmpty) ? ' ' : '');
    result += hr + ((hr.isNotEmpty) ? ':' : '');
    result += mn + ((mn.isNotEmpty) ? ':' : '');
    result += sc;

    return result;
  }

  String formattedString(
      {List<String> yearPlurality = const ['yr', 'yrs'],
      List<String> monthsPlurality = const ['mo', 'mos'],
      List<String> daysPlurality = const ['dy', 'dys'],
      List<String> hoursPlurality = const ['hr', 'hrs'],
      List<String> minutesPlurality = const ['min', 'mins'],
      List<String> secondsPlurality = const ['sec', 'secs']}) {
    if (yearPlurality.length != 2) throw FlutterError('"years" must have two values');
    if (monthsPlurality.length != 2) throw FlutterError('"months" must have two values');
    if (daysPlurality.length != 2) throw FlutterError('"days" must have two values');
    if (hoursPlurality.length != 2) throw FlutterError('"hours" must have two values');
    if (minutesPlurality.length != 2) throw FlutterError('"minutes" must have two values');
    if (secondsPlurality.length != 2) throw FlutterError('"seconds" must have two values');
    String _result = '';
    void add(int? value, List<String> unit) {
      if (value == null) return;
      if (value == 0 && _result.isEmpty) return;
      if (_result.isNotEmpty) _result = '$_result ';
      final theUnit = (value == 1) ? unit[0] : unit[1];
      _result = '$_result${NumberFormat('#,###').format(value)} $theUnit';
    }

    add(_years, yearPlurality);
    add(_months, monthsPlurality);
    add(_days, daysPlurality);
    add(_hours, hoursPlurality);
    add(_minutes, minutesPlurality);
    add(_seconds, secondsPlurality);
    return _result;
  }

  void _approximateInterval(Set<DateTimeElement?> setOfCalendarItems, DateTime startingDateTime, DateTime endingDateTime) {
    int _getTotalMonths(DateTime startEvent, DateTime endEvent) {
      int months = 0;
      while (DateTime(
            startEvent.year,
            (startEvent.month + months + 1),
            startEvent.day,
            startEvent.hour,
            startEvent.minute,
            startEvent.second,
          ).compareTo(endEvent) <
          0) {
        months++;
      }
      return months;
    }

    int _totalMonths = _getTotalMonths(startingDateTime, endingDateTime);
    _years = !setOfCalendarItems.contains(DateTimeElement.year) ? null : _totalMonths ~/ _MONTHS_PER_YEAR;
    _months = !setOfCalendarItems.contains(DateTimeElement.month) ? null : _totalMonths - ((_years ?? 0) * _MONTHS_PER_YEAR);
    DateTime adjustedEvent = DateTime(
      startingDateTime.year,
      startingDateTime.month + _totalMonths,
      startingDateTime.day,
      startingDateTime.hour,
      startingDateTime.minute,
      startingDateTime.second,
    );
    final duration = endingDateTime.difference(adjustedEvent);
    _days = !setOfCalendarItems.contains(DateTimeElement.day) ? null : duration.inDays;
    _hours = !setOfCalendarItems.contains(DateTimeElement.hour) ? null : duration.inHours - ((_days ?? 0) * _HOURS_PER_DAY);
    _minutes = !setOfCalendarItems.contains(DateTimeElement.minute) ? null : duration.inMinutes - ((_hours ?? 0) * _MINUTES_PER_HOUR) - ((_days ?? 0) * _MINUTES_PER_DAY);
    _seconds = !setOfCalendarItems.contains(DateTimeElement.second)
        ? null
        : duration.inSeconds - ((_days ?? 0) * _SECONDS_PER_DAY) - ((_hours ?? 0) * _SECONDS_PER_HOUR) - ((_minutes ?? 0) * _SECONDS_PER_MINUTE);
  }

  //Rebuild DateTime micro and milli seconds set to zero(0)
  void _exactInterval(Set<DateTimeElement?> setOfCalendarItems, DateTime startingDateTime, DateTime endingDateTime) {
    _days = !setOfCalendarItems.contains(DateTimeElement.day) ? null : endingDateTime.difference(startingDateTime).inDays;
    _hours = !setOfCalendarItems.contains(DateTimeElement.hour) ? null : endingDateTime.difference(startingDateTime).inHours - ((_days ?? 0) * _HOURS_PER_DAY);
    _minutes = !setOfCalendarItems.contains(DateTimeElement.minute)
        ? null
        : endingDateTime.difference(startingDateTime).inMinutes - ((_hours ?? 0) * _MINUTES_PER_HOUR) - ((_days ?? 0) * _MINUTES_PER_DAY);
    _seconds = !setOfCalendarItems.contains(DateTimeElement.second)
        ? null
        : endingDateTime.difference(startingDateTime).inSeconds - ((_days ?? 0) * _SECONDS_PER_DAY) - ((_hours ?? 0) * _SECONDS_PER_HOUR) - ((_minutes ?? 0) * _SECONDS_PER_MINUTE);
  }

  String _pad(int? value, [bool trunc = true]) {
    if (value == null) return trunc ? '' : '00';
    if (value == 0 && trunc) return '';
    return value.toString().padLeft(2, '0');
  }

  DateTime _timeWrapper(DateTime dateTime) {
    return DateTime(
      dateTime.year,
      dateTime.month,
      dateTime.day,
      dateTime.hour,
      dateTime.minute,
      dateTime.second,
      0,
      0,
    );
  }
}
