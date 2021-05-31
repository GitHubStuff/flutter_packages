import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../constants.dart' as K;

class PickerText extends StatelessWidget {
  final String text;

  PickerText({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: K.padding,
      child: Center(
        child: AutoSizeText(
          '$text',
          style: K.textStyle(context: context),
          maxLines: 1,
        ),
      ),
    );
  }
}
