part of 'email_cubit.dart';

@immutable
abstract class EmailState {}

class EmailInitial extends EmailState {}

class HasValidEmail extends EmailState {
  final bool valid;
  HasValidEmail(this.valid);
}
