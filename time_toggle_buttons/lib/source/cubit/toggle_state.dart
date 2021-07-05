part of 'toggle_cubit.dart';

@immutable
abstract class ToggleState {}

class ToggleInitial extends ToggleState {
  final List<bool> states;
  ToggleInitial(this.states);
}
