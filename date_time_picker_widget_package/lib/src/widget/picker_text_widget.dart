import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import 'const.dart';

class PickerTextWidget extends StatelessWidget {
  const PickerTextWidget({
    Key? key,
    required this.text,
    required this.style,
  }) : super(key: key);

  final String text;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Const.padding,
      child: Center(
        child: AutoSizeText(
          '$text',
          style: style.copyWith(fontSize: Const.fontSize),
          maxLines: 1,
        ),
      ),
    );
  }
}
