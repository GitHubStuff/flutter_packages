// Copyright 2021, LTMM LLC
import 'package:flutter/material.dart';

import '../../src/theme/text_keys.dart';

extension TextKeysExtension on TextKey {
  Color getColor({required Brightness forBrightness}) => (forBrightness == Brightness.dark) ? textColorDarkMode[this]! : textColorLightMode[this]!;

  TextStyle asTextStyle({required Brightness forBrightness}) => TextStyle().merge(
        TextStyle(
          color: getColor(forBrightness: forBrightness),
          fontSize: getFontSize,
        ),
      );
  double get getFontSize => textSizeMap[this]!;
}
