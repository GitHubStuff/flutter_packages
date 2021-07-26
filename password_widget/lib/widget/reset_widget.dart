import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_extras/source/observing_stateful_widget.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:passwordwidget/cubit/signin_cubit.dart';

import '../constants.dart' as K;
import '../cubit/login_cubit.dart';
import '../source/email_widget.dart';
import '../source/signin_button.dart';

class ResetWidget extends StatefulWidget {
  _ResetWidget createState() => _ResetWidget();
}

class _ResetWidget extends ObservingStatefulWidget<ResetWidget> {
  LoginCubit _loginCubit = LoginCubit();
  bool _enableReset = false;

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
                if (state is EnableButton) _enableReset = state.enable;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    EmailWidget(
                      callback: (txt) {
                        _loginCubit.collectJustEmail(txt);
                      },
                    ),
                    SizedBox(
                      height: 14.0,
                    ),
                    SignInButton(
                      enabled: _enableReset,
                      caption: 'Reset',
                      widgetCallback: () {
                        Modular.get<SigninCubit>().reset(_loginCubit.email);
                      },
                    ),
                    SizedBox(
                      height: 14.0,
                    ),
                    SignInButton(
                      enabled: true,
                      caption: 'Cancel',
                      widgetCallback: () {
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
      border: Border.all(color: K.borderColors.of(context: context)),
    );
  }
}
