part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class EnableButton extends LoginState {
  final bool enable;
  EnableButton(this.enable);
}
