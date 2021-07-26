part of 'password_cubit.dart';

@immutable
abstract class PasswordState {}

class PasswordInitial extends PasswordState {}

class ToggleVisibility extends PasswordState {}

class HasValidPassword extends PasswordState {
  final bool valid;
  HasValidPassword(this.valid);
}
