import 'dart:core';

import 'package:bloc/bloc.dart';
import 'package:date_time_package/date_time_package.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'date_time_state.dart';

class DateTimeCubit extends Cubit<DateTimeState> {
  DateTime? _dateTime;
  DateTimeCubit([this._dateTime]) : super(DateTimeInitial());

  void Function(Change<DateTimeState>)? onChangeCallback;

  DateTime get utcDateTime => _set.toUtc();

  DateTime get _set => _dateTime = _dateTime ?? DateTime.now();

  @override
  void onChange(Change<DateTimeState> change) {
    super.onChange(change);
    onChangeCallback?.call(change);
  }

  void changeYear(int year) {
    final delta = (year - _set.year);
    _dateTime = _set.next(DateTimeElement.year, delta);
    debugPrint('CUBIT: $_dateTime');
    emit(ChangeDateTimeState(_dateTime!));
  }

  void changeMonth(int month) {
    final delta = (month - _set.month);
    _dateTime = _set.next(DateTimeElement.month, delta);
    emit(ChangeDateTimeState(_dateTime!));
  }

  void changeDay(int day) {
    final delta = (day - _set.day);
    _dateTime = _set.next(DateTimeElement.day, delta);
    emit(ChangeDateTimeState(_dateTime!));
  }

  int get year => _set.year;
  int get month => _set.month;
  int get day => _set.day;
  int get daysInTheMonth => _set.daysInTheMonth;
}
