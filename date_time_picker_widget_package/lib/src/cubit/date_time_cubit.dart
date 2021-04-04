import 'dart:core';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:date_time_package/date_time_package.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../src/widget/const.dart';

part 'date_time_state.dart';

class DateTimeCubit extends Cubit<DateTimeState> {
  DateTime? _dateTime;
  FixedExtentScrollController? _dayScroller;

  DateTimeCubit([this._dateTime]) : super(DateTimeInitial());

  void Function(Change<DateTimeState>)? onChangeCallback;

  DateTime get utcDateTime => _set.toUtc();

  DateTime get _set => _dateTime = _dateTime ?? DateTime.now();

  int? _oldDayCount;

  @override
  void onChange(Change<DateTimeState> change) {
    super.onChange(change);
    onChangeCallback?.call(change);
  }

  void changeYear(int year) {
    final delta = (year - _set.year);
    _dateTime = _set.next(DateTimeElement.year, delta);
    _updateDay();
  }

  void changeMonth(int month) {
    final delta = (month - _set.month);
    _dateTime = _set.next(DateTimeElement.month, delta);
    _updateDay();
  }

  void changeDay(int day) {
    final delta = (day - _set.day);
    _dateTime = _set.next(DateTimeElement.day, delta);
    _updateDay();
  }

  void changeMeridian({required int index}) {
    switch (index) {
      case Const.amIndex:
        _dateTime = _set.update(DateTimeElement.hour, to: hour24 - 12);
        break;
      case Const.pmIndex:
        _dateTime = _set.update(DateTimeElement.hour, to: hour24 + 12);
        break;
      default:
        throw Exception('Unknown meridian index $index');
    }
    debugPrint('Meridian: $index => $_set');
  }

  void change(DateTimeElement element, {required int to}) {
    switch (element) {
      case DateTimeElement.hour:
        int newHour = (to == 12) ? (meridianIndex == Const.amIndex ? 0 : 12) : (meridianIndex == Const.amIndex ? to : to + 12);
        _dateTime = _set.update(element, to: newHour);
        break;
      case DateTimeElement.minute:
      case DateTimeElement.second:
        _dateTime = _set.update(element, to: to);
        break;

      default:
        throw FlutterError('Can not change ${element.toString()} with this method');
    }
    debugPrint('Element: $element => $_set');
  }

  void _updateDay() async {
    bool refresh = _oldDayCount != _set.daysInTheMonth;
    _oldDayCount = _set.daysInTheMonth;

    if (refresh && _dayScroller != null) {
      _dayScroller!.jumpToItem(max(_set.day - 1, 1));
      await Future.delayed(Duration(microseconds: 1), () {
        _dayScroller!.jumpToItem(_set.day);
        emit(ChangeDateTimeState(_dateTime!));
      });
    }
    debugPrint('UpdateDay => $_set');
  }

  void setScrollController(FixedExtentScrollController scrollController) => _dayScroller = scrollController;

  int get year => fetch(DateTimeElement.year);
  int get month => fetch(DateTimeElement.month);
  int get day => fetch(DateTimeElement.day);
  int get daysInTheMonth => _set.daysInTheMonth;
  int get meridianIndex => _set.hour < 12 ? Const.amIndex : Const.pmIndex;
  int get hour24 => _set.hour;
  int get hour12 => _set.hour12;

  int fetch(DateTimeElement element) {
    switch (element) {
      case DateTimeElement.year:
        return _set.year;
      case DateTimeElement.month:
        return _set.month;
      case DateTimeElement.day:
        return _set.day;
      case DateTimeElement.hour:
        return _set.hour;
      case DateTimeElement.minute:
        return _set.minute;
      case DateTimeElement.second:
        return _set.second;
      case DateTimeElement.millisecond:
        return _set.millisecond;
      case DateTimeElement.microsecond:
        return _set.microsecond;
    }
  }
}
