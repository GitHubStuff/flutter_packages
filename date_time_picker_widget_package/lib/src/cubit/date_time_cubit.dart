import 'dart:core';

import 'package:bloc/bloc.dart';
import 'package:date_time_package/date_time_package.dart';
import 'package:meta/meta.dart';

part 'date_time_state.dart';

class DateTimeCubit extends Cubit<DateTimeState> {
  DateTime? _dateTime;
  DateTimeCubit([this._dateTime]) : super(DateTimeInitial());

  void Function(Change<DateTimeState>)? onChangeCallback;

  DateTime get utcDateTime => _set();

  DateTime _set() {
    _dateTime = _dateTime ?? DateTime.now();
    return _dateTime!;
  }

  @override
  void onChange(Change<DateTimeState> change) {
    super.onChange(change);
    onChangeCallback?.call(change);
  }

  void changeYear(int year) {
    final delta = (year - _set().year);
    final currentDay = _dateTime!.day;
    _dateTime = _set().next(DateTimeElement.year, delta);
    emit(ChangeYearState(_dateTime!));
    if (currentDay != _dateTime!.day) emit(ChangeDayState(_dateTime!));
  }
}
