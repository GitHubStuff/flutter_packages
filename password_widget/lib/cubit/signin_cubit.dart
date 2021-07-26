import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../constants.dart' as K;

part 'signin_state.dart';

class SigninCubit extends Cubit<SigninState> {
  K.WidgetType widgetType = K.WidgetType.signin;

  SigninCubit() : super(SigninInitial());

  Future signin(String userEmail, String userPassword) async {
    assert(false, 'Do something');
  }

  Future setMode(K.WidgetType type) async {
    emit(SetSignMode(type));
  }
}
