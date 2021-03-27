part of 'date_time_cubit.dart';

enum DateTimeStateType {
  DateTimeInitial,
  ChangeYearState,
  ChangeDayState,
}

@immutable
abstract class DateTimeState {
  final DateTimeStateType type;
  const DateTimeState(this.type);
}

class ChangeDayState extends DateTimeState {
  final DateTime dateTime;
  const ChangeDayState(this.dateTime) : super(DateTimeStateType.ChangeDayState);
}

class DateTimeInitial extends DateTimeState {
  const DateTimeInitial() : super(DateTimeStateType.DateTimeInitial);
}

class ChangeYearState extends DateTimeState {
  final DateTime dateTime;

  const ChangeYearState(this.dateTime) : super(DateTimeStateType.ChangeYearState);
}
