import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:passwordwidget/data/identity.dart';

import '../constants.dart' as K;

part 'signin_state.dart';

class SigninCubit extends Cubit<SigninState> {
  K.WidgetType widgetType = K.WidgetType.signin;
  Identity? identity;

  SigninCubit() : super(SigninInitial());

  Future signin(String userEmail, String userPassword) async {
    identity = Identity(widgetType: K.WidgetType.signin, email: userEmail, password: userPassword);
    emit(UserSigninAction(identity!));
  }

  Future register(String userEmail, String userPassword) async {
    identity = Identity(widgetType: K.WidgetType.register, email: userEmail, password: userPassword);
    emit(UserSigninAction(identity!));
  }

  Future reset(String userEmail) async {
    identity = Identity(widgetType: K.WidgetType.reset, email: userEmail);
    emit(UserSigninAction(identity!));
  }

  Future setMode(K.WidgetType type) async {
    emit(SetSignMode(type));
  }
}
