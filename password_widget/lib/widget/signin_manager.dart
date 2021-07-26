import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_extras/source/observing_stateful_widget.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:passwordwidget/widget/register_widget.dart';
import 'package:passwordwidget/widget/reset_widget.dart';

import '../constants.dart' as K;
import '../cubit/signin_cubit.dart';
import '../widget/login_widget.dart';

class SignInManager extends StatefulWidget {
  const SignInManager({Key? key}) : super(key: key);

  @override
  _SignInManager createState() => _SignInManager();
}

class _SignInManager extends ObservingStatefulWidget<SignInManager> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SigninCubit, SigninState>(
        bloc: Modular.get<SigninCubit>(),
        builder: (contxt, state) {
          if (state is SigninInitial) {
            return LoginWidget();
          }
          if (state is SetSignMode) {
            switch (state.widgetType) {
              case K.WidgetType.register:
                return RegisterWidget();
              case K.WidgetType.reset:
                return ResetWidget();
              case K.WidgetType.signin:
                return LoginWidget();
            }
          }
          return Text('YA');
        });
  }
}
