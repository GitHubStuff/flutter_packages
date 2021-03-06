part of 'keypad_cubit.dart';

@immutable
abstract class KeypadState {}

class KeypadInitial extends KeypadState {}

class KeypadValued extends KeypadState {
  final String text;
  KeypadValued(this.text);
}

class KeypadValueSet extends KeypadState {
  final String value;
  KeypadValueSet(this.value);
}
