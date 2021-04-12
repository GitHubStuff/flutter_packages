// Copyright 2021, LTMM LLC
// Single source to display text in a picker widget
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../constants/constants.dart' as K;

class PickerTextWidget extends StatelessWidget {
  final String text;
  final TextStyle style;
  final Color textColor;

  const PickerTextWidget({
    Key? key,
    required this.text,
    required this.style,
    required this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: K.padding,
      child: Center(
        child: AutoSizeText(
          '$text',
          style: style.copyWith(fontSize: K.fontSize, color: textColor),
          maxLines: 1,
        ),
      ),
    );
  }
}
