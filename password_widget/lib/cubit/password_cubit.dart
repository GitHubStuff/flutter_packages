import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'password_state.dart';

class PasswordCubit extends Cubit<PasswordState> {
  PasswordCubit() : super(PasswordInitial());

  final String _regexSource = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{10,}$';

  void toggleVisibility() {
    emit(ToggleVisibility());
  }

  void isValid(String value) {
    try {
      final regexp = RegExp(_regexSource);
      final result = regexp.hasMatch(value);
      emit(HasValidPassword(result));
    } catch (e) {
      // Invalid regex
      assert(false, e.toString());
    }
  }
}
