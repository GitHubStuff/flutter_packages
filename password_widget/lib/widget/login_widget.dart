import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_extras/source/observing_stateful_widget.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:siginwidget/sigin_widget.dart';

import '../constants.dart' as K;
import '../cubit/login_cubit.dart';
import '../source/email_widget.dart';
import '../source/sigin_widget.dart';
import '../source/signin_button.dart';

class LoginWidget extends StatefulWidget {
  _LoginWidget createState() => _LoginWidget();
}

class _LoginWidget extends ObservingStatefulWidget<LoginWidget> {
  LoginCubit _loginCubit = LoginCubit();
  bool _enableSignIn = false;

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
                if (state is EnableButton) _enableSignIn = state.enable;
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
                    Siginwidget(
                      callback: (txt) {
                        _loginCubit.collectPassword(txt);
                      },
                    ),
                    SizedBox(
                      height: 14.0,
                    ),
                    SignInButton(
                      enabled: _enableSignIn,
                      caption: 'Sign In',
                      widgetCallback: () {
                        Modular.get<SigninCubit>().signin(_loginCubit.email, _loginCubit.password);
                      },
                    ),
                    SizedBox(
                      height: 32.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SignInButton(
                          caption: 'Register',
                          widgetCallback: () {
                            Modular.get<SigninCubit>().setMode(K.WidgetType.register);
                          },
                        ),
                        SignInButton(
                          caption: 'Reset',
                          widgetCallback: () {
                            Modular.get<SigninCubit>().setMode(K.WidgetType.reset);
                          },
                        ),
                      ],
                    )
                  ],
                );
              }),
        ),
      ),
    );
  }

  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
      border: Border.all(color: K.borderColors.of(context: context)),
    );
  }
}
