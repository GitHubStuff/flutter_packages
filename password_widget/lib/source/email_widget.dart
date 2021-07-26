import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_extras/flutter_extras.dart';

import '../constants.dart' as K;
import '../cubit/email_cubit.dart';

class EmailWidget extends StatefulWidget {
  final K.TextCallback callback;

  EmailWidget({Key? key, required this.callback}) : super(key: key);

  _EmailWidget createState() => _EmailWidget();
}

class _EmailWidget extends ObservingStatefulWidget<EmailWidget> {
  String _helperText = K.badEmail;

  EmailCubit _emailCubit = EmailCubit();
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
    _emailCubit.isValid(_textEditingController.text);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: _emailCubit,
        builder: (contxt, state) {
          if (state is HasValidEmail) {
            if (state.valid) {
              widget.callback(_textEditingController.text);
              _helperText = K.goodEmail;
            } else {
              widget.callback('');
              _helperText = K.badEmail;
            }
          }
          return SizedBox(
            width: K.boxWidth,
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              controller: _textEditingController,
              obscureText: false,
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
        labelText: 'Email',
        helperText: _helperText,
      );
}
