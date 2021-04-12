//Copyright 2021, LTMM LLC
import 'dart:core';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:date_time_package/date_time_package.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

import '../../src/constants/constants.dart' as K;

part 'date_time_state.dart';

class DateTimeCubit extends Cubit<DateTimeState> {
  DateTime? _dateTime;

  /// Constructor
  DateTimeCubit([this._dateTime]) : super(DateTimeInitial());

  FixedExtentScrollController? _dayScroller;

  void Function(Change<DateTimeState>)? onChangeCallback;

  DateTime get utcDateTime => dateTime.toUtc();

  DateTime get dateTime => _dateTime = _dateTime ?? DateTime.now();

  int? _oldDayCount;

  @override
  void onChange(Change<DateTimeState> change) {
    super.onChange(change);
    onChangeCallback?.call(change);
  }

  void change(DateTimeElement element, {required int to}) {
    switch (element) {
      case DateTimeElement.hour:
        int newHour = (to == K.noonOrMidnight) ? (meridianIndex == K.amIndex ? K.midnight : K.noon) : (meridianIndex == K.amIndex ? to : to + K.noon);
        _dateTime = dateTime.update(element, to: newHour);
        break;
      case DateTimeElement.minute:
      case DateTimeElement.second:
        _dateTime = dateTime.update(element, to: to);
        break;

      default:
        throw FlutterError('Can not change ${element.toString()} with this method');
    }
    emit(ChangeDateTimeState(_dateTime!));
    //debugPrint('Element: $element => $_set');
  }

  void changeDay(int day) {
    final delta = (day - dateTime.day);
    _dateTime = dateTime.next(DateTimeElement.day, delta);
    _updateDay();
  }

  void changeMeridian({required int index}) {
    switch (index) {
      case K.amIndex:
        _dateTime = dateTime.update(DateTimeElement.hour, to: hour24 - K.noon);
        break;
      case K.pmIndex:
        _dateTime = dateTime.update(DateTimeElement.hour, to: hour24 + K.noon);
        break;
      default:
        throw Exception('Unknown meridian index $index');
    }
    emit(ChangeDateTimeState(_dateTime!));
    //debugPrint('Meridian: $index => $_set');
  }

  void changeMonth(int month) {
    final delta = (month - dateTime.month);
    _dateTime = dateTime.next(DateTimeElement.month, delta);
    _updateDay();
  }

  void changeYear(int year) {
    final delta = (year - dateTime.year);
    _dateTime = dateTime.next(DateTimeElement.year, delta);
    _updateDay();
  }

  void _updateDay() async {
    bool refresh = _oldDayCount != dateTime.daysInTheMonth;
    _oldDayCount = dateTime.daysInTheMonth;

    ///Force a scroll to force UI to display updated number of days
    if (refresh && _dayScroller != null) {
      _dayScroller!.animateToItem(max(dateTime.day + ((K.infiniteWheelFactor * dateTime.daysInTheMonth) - 1), 1), duration: Duration(microseconds: 1), curve: Curves.bounceOut);
      _dayScroller!.animateToItem(dateTime.day + (K.infiniteWheelFactor * dateTime.daysInTheMonth), duration: Duration(microseconds: 1), curve: Curves.bounceIn);
    }
    emit(ChangeDateTimeState(_dateTime!));
    //debugPrint('UpdateDay => $_set');
  }

  String formattedDateTime([String formatted = K.dateTimeFormatString]) => DateFormat(formatted).format(dateTime);
  int get day => fetch(DateTimeElement.day);
  int get daysInTheMonth => dateTime.daysInTheMonth;
  int get meridianIndex => dateTime.hour < K.noon ? K.amIndex : K.pmIndex;
  int get hour24 => dateTime.hour;
  int get hour12 => dateTime.hour12;
  int get month => fetch(DateTimeElement.month);
  int get year => fetch(DateTimeElement.year);
  void setScrollController(FixedExtentScrollController scrollController) => _dayScroller = scrollController;

  int fetch(DateTimeElement element) {
    switch (element) {
      case DateTimeElement.year:
        return dateTime.year;
      case DateTimeElement.month:
        return dateTime.month;
      case DateTimeElement.day:
        return dateTime.day;
      case DateTimeElement.hour:
        return dateTime.hour;
      case DateTimeElement.minute:
        return dateTime.minute;
      case DateTimeElement.second:
        return dateTime.second;
      case DateTimeElement.millisecond:
        return dateTime.millisecond;
      case DateTimeElement.microsecond:
        return dateTime.microsecond;
    }
  }

  void dateTimeSelected() => emit(SetDateTimeState(dateTime.round()));
}
