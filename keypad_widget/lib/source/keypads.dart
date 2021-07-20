import 'package:flutter/material.dart';
import 'package:keypad_popover/source/button_abstract.dart';
import 'package:keypad_popover/source/keypad_grid.dart';

class CalculatorKeypad extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return KeypadGrid([
      SevenButton().widget(context),
      EightButton().widget(context),
      NineButton().widget(context),
      FourButton().widget(context),
      FiveButton().widget(context),
      SixButton().widget(context),
      OneButton().widget(context),
      TwoButton().widget(context),
      ThreeButton().widget(context),
      DecimalButton().widget(context),
      ZeroButton().widget(context),
      DeleteButton().widget(context),
    ]);
  }
}

class PhoneKeypad extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return KeypadGrid([
      OneButton().widget(context),
      TwoButton().widget(context),
      ThreeButton().widget(context),
      FourButton().widget(context),
      FiveButton().widget(context),
      SixButton().widget(context),
      SevenButton().widget(context),
      EightButton().widget(context),
      NineButton().widget(context),
      DecimalButton().widget(context),
      ZeroButton().widget(context),
      DeleteButton().widget(context),
    ]);
  }
}
