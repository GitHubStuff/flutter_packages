// Copyright 2021, LTMM LLC
import 'package:flutter/material.dart';

import '../../theme_manager.dart';
import 'theme_mode_extensions.dart';

extension TextKeysExtension on TextKey {
  Color getColor({required Brightness forBrightness}) => (forBrightness == Brightness.dark) ? textColorDarkMode[this]! : textColorLightMode[this]!;

  TextStyle asTextStyle({required Brightness forBrightness}) => TextStyle().merge(
        TextStyle(
          color: getColor(forBrightness: forBrightness),
          fontSize: getFontSize,
        ),
      );

  TextStyle asTextStyleOf({required BuildContext context, required ThemeMode themeMode}) => asTextStyle(
        forBrightness: themeMode.asBrightness(context: context),
      );

  double get getFontSize => textSizeMap[this]!;
}
