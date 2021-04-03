import 'dart:core';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:date_time_package/date_time_package.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

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
  }

  void setScrollController(FixedExtentScrollController scrollController) => _dayScroller = scrollController;

  int get year => _set.year;
  int get month => _set.month;
  int get day => _set.day;
  int get daysInTheMonth => _set.daysInTheMonth;
}
