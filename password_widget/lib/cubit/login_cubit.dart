import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  String email = '';
  String password = '';

  LoginCubit() : super(LoginInitial());

  void collectPassword(String pass) {
    password = pass;
    emit(EnableButton(password.isNotEmpty && email.isNotEmpty));
  }

  void collectEmail(String eMail) {
    email = eMail;
    emit(EnableButton(password.isNotEmpty && email.isNotEmpty));
  }
}
