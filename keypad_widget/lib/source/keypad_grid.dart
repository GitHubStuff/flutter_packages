import 'package:flutter/material.dart';

import '../source/constants.dart' as K;

//import 'button_abstract.dart';

class KeypadGrid extends StatelessWidget {
  final List<Widget> buttons;

  KeypadGrid(this.buttons);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: K.keypadHeight,
      width: K.keypadWidth,
      child: GridView.count(
        crossAxisCount: 3,
        children: buttons,
      ),
    );
  }
}
