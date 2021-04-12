// Copyright 2021, LTMM LLC
// Single source to display text in a picker widget
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../constants/constants.dart' as K;

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
      padding: K.padding,
      child: Center(
        child: AutoSizeText(
          '$text',
          style: style.copyWith(fontSize: K.fontSize),
          maxLines: 1,
        ),
      ),
    );
  }
}
