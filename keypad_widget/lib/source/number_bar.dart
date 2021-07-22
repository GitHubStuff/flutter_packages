import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_extras/flutter_extras.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:keypad_popover/keypad_popover.dart';

import '../source/constants.dart' as K;
import 'keypads.dart';

class NumberBar extends StatefulWidget {
  _NumberBar createState() => _NumberBar();
}

class _NumberBar extends ObservingStatefulWidget<NumberBar> {
  final TextEditingController _textEditingController = TextEditingController()..text = '0';

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: K.keypadWidth,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              height: K.inputBarHeight,
              child: Row(
                children: [
                  _setButton(),
                  _input(),
                ],
              ),
            ),
            CalculatorKeypad(),
          ],
        ),
      ),
    );
  }

  Widget _setButton() => Padding(
        padding: const EdgeInsets.only(
          top: 3,
          bottom: 3,
          right: 6,
          left: 12,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(K.buttonBody / 2.0),
          ),
          child: TextButton(
              child: Text(
                K.setterButtonText,
                style: K.setButtonStyle(context),
              ),
              onPressed: () {
                Modular.get<KeypadCubit>().setButtonPressed();
              }),
        ),
      );

  Widget _input() {
    return Expanded(
      child: BlocBuilder<KeypadCubit, KeypadState>(
        bloc: Modular.get<KeypadCubit>(),
        builder: (context, state) {
          if (state is KeypadValued) {
            _textEditingController.text = state.text;
          }
          return TextField(
            controller: _textEditingController,
            obscureText: false,
            textDirection: TextDirection.rtl,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Numbers',
            ),
          );
        },
      ),
    );
  }
}
