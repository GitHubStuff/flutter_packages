import 'package:flutter/material.dart';
import 'package:theme_manager/theme_manager.dart';

const double inputBarHeight = 48.0;
const double buttonBody = buttonSize - buttonPadding;
const double buttonPadding = 8.0;
const double buttonSize = 72.0;
const decimalString = '.';
const double keypadHeight = buttonSize * 4.0;
const double keypadWidth = (buttonSize * 3.0);
const setterButtonText = 'Set';

const ThemeColors defaultBackgroundColors = ThemeColors(
  dark: Colors.white30,
  light: Colors.white70,
);

const ThemeColors buttonColors = ThemeColors(
  dark: Color(0xFF1B5E20),
  light: Colors.blueAccent,
);

final ThemeColors textColors = ThemeColors(
  dark: Colors.black,
  light: Colors.black,
);
TextStyle setButtonStyle(BuildContext context) => TextStyle(
      fontSize: textSizeMap[TextKey.headline5],
      color: textColors.of(context: context),
    );

TextStyle textStyle(BuildContext context) => TextStyle(
      fontSize: textSizeMap[TextKey.headline5],
      color: textColors.of(context: context),
    );

enum ButtonContent {
  number,
  decimal,
  delete,
  star,
  pound,
}

enum KeypadTypes {
  money,
  integer,
  real,
}
