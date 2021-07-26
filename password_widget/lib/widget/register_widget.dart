import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_extras/source/observing_stateful_widget.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:passwordwidget/cubit/signin_cubit.dart';

import '../constants.dart' as K;
import '../cubit/login_cubit.dart';
import '../source/email_widget.dart';
import '../source/password_widget.dart';
import '../source/signin_button.dart';

class RegisterWidget extends StatefulWidget {
  _RegisterWidget createState() => _RegisterWidget();
}

class _RegisterWidget extends ObservingStatefulWidget<RegisterWidget> {
  LoginCubit _loginCubit = LoginCubit();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        decoration: myBoxDecoration(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<LoginCubit, LoginState>(
              bloc: _loginCubit,
              builder: (contxt, state) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    EmailWidget(
                      callback: (txt) {
                        _loginCubit.collectEmail(txt);
                      },
                    ),
                    SizedBox(
                      height: 28.0,
                    ),
                    PasswordWidget(
                      callback: (txt) {
                        _loginCubit.collectPassword(txt);
                      },
                    ),
                    SizedBox(
                      height: 14.0,
                    ),
                    SignInButton(
                      enabled: true,
                      caption: 'Register',
                      widgetType: K.WidgetType.register,
                      widgetCallback: (type) {},
                    ),
                    SizedBox(
                      height: 14.0,
                    ),
                    SignInButton(
                      enabled: true,
                      caption: 'Cancel',
                      widgetType: K.WidgetType.register,
                      widgetCallback: (type) {
                        Modular.get<SigninCubit>().setMode(K.WidgetType.signin);
                      },
                    ),
                  ],
                );
              }),
        ),
      ),
    );
  }

  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
      border: Border.all(),
    );
  }
}
