import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_extras/flutter_extras.dart';

import '../constants.dart' as K;
import '../cubit/password_cubit.dart';

class Siginwidget extends StatefulWidget {
  final K.TextCallback callback;

  Siginwidget({Key? key, required this.callback}) : super(key: key);

  _Siginwidget createState() => _Siginwidget();
}

class _Siginwidget extends ObservingStatefulWidget<Siginwidget> {
  bool _hidePassword = true;
  String _helperText = K.helperText;

  PasswordCubit _passwordCubit = PasswordCubit();
  TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _textEditingController.addListener(_onChange);
  }

  @override
  dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  void _onChange() {
    _passwordCubit.isValid(_textEditingController.text);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: _passwordCubit,
        builder: (contxt, state) {
          if (state is ToggleVisibility) _hidePassword = !_hidePassword;
          if (state is HasValidPassword) {
            if (state.valid) {
              widget.callback(_textEditingController.text);
              _helperText = K.goodPassword;
            } else {
              widget.callback('');
              _helperText = K.helperText;
            }
          }
          return SizedBox(
            width: K.boxWidth,
            child: TextField(
              controller: _textEditingController,
              obscureText: _hidePassword,
              decoration: _inputDecoration,
            ),
          );
        });
  }

  InputDecoration get _inputDecoration => InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: K.borderColors.of(context: context),
          ),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: K.borderColors.of(context: context),
          ),
        ),
        labelText: 'Password',
        helperText: _helperText,
        suffixIcon: _iconButton,
      );

  Widget get _iconButton => IconButton(
        icon: Icon(
          _hidePassword ? Icons.visibility : Icons.visibility_off,
        ),
        onPressed: () {
          _passwordCubit.toggleVisibility();
        },
      );
}
