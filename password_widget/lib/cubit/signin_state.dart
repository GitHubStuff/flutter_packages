part of 'signin_cubit.dart';

@immutable
abstract class SigninState {}

class SigninInitial extends SigninState {}

class SetSignMode extends SigninState {
  final K.WidgetType widgetType;
  SetSignMode(this.widgetType);
}
