import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:keypad_popover/keypad_popover.dart';
import 'package:keypad_popover/source/constants.dart' as K;

/// The keypad buttons
abstract class ButtonAbstract {
  final String text;
  final K.ButtonContent content;
  bool enabled = true;
  ButtonAbstract({
    required this.text,
    this.content = K.ButtonContent.number,
  });

  Widget widget(BuildContext context) {
    return SizedBox(
      height: K.buttonSize,
      width: K.buttonSize,
      child: Padding(
        padding: const EdgeInsets.all(K.buttonPadding),
        child: Container(
          decoration: BoxDecoration(
            color: K.buttonColors.of(context: context),
            borderRadius: BorderRadius.circular(K.buttonBody / 2.0),
          ),
          child: TextButton(
            child: Text(text, style: K.textStyle(context)),
            onPressed: () {
              final keypadCubit = Modular.get<KeypadCubit>();
              keypadCubit.add(text, content);
            },
            style: TextButton.styleFrom(
              padding: const EdgeInsets.all(K.buttonPadding),
            ),
          ),
        ),
      ),
    );
  }
}

class ZeroButton extends ButtonAbstract {
  ZeroButton() : super(text: '0');
}

class OneButton extends ButtonAbstract {
  OneButton() : super(text: '1');
}

class TwoButton extends ButtonAbstract {
  TwoButton() : super(text: '2');
}

class ThreeButton extends ButtonAbstract {
  ThreeButton() : super(text: '3');
}

class FourButton extends ButtonAbstract {
  FourButton() : super(text: '4');
}

class FiveButton extends ButtonAbstract {
  FiveButton() : super(text: '5');
}

class SixButton extends ButtonAbstract {
  SixButton() : super(text: '6');
}

class SevenButton extends ButtonAbstract {
  SevenButton() : super(text: '7');
}

class EightButton extends ButtonAbstract {
  EightButton() : super(text: '8');
}

class NineButton extends ButtonAbstract {
  NineButton() : super(text: '9');
}

class DecimalButton extends ButtonAbstract {
  DecimalButton() : super(text: '.', content: K.ButtonContent.decimal);
}

class DeleteButton extends ButtonAbstract {
  DeleteButton() : super(text: '<', content: K.ButtonContent.delete);
}
