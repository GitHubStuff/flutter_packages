part of 'date_time_cubit.dart';

enum DateTimeStateType {
  DateTimeInitial,
  ChangeYearState,
  ChangeDayState,
}

@immutable
abstract class DateTimeState {
  const DateTimeState();
}

class DateTimeInitial extends DateTimeState {
  const DateTimeInitial();
}

class ChangeDateTimeState extends DateTimeState {
  final DateTime dateTime;
  const ChangeDateTimeState(this.dateTime);
}

class SetDateTimeState extends DateTimeState {
  final DateTime dateTime;
  const SetDateTimeState(this.dateTime);
}
