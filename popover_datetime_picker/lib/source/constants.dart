import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:theme_manager/theme_manager.dart';

const double minimalPopoverHeight = 247.5;
const double minimalScrollHeightFactor = 0.64646464;
const Duration crossFadeDuration = const Duration(milliseconds: 400);
const EdgeInsets padding = EdgeInsets.all(4.0);
const EdgeInsets seperatorPadding = EdgeInsets.only(top: 4, bottom: 4);
const Size minimalPickerSize = const Size(280.0, minimalPopoverHeight * minimalScrollHeightFactor);
const Size minimalPopoverSize = const Size(280.0, minimalPopoverHeight);
const String dateFormatString = 'EEE, MMM d, yyyy';
const String dateText = 'Date';
const String dateTimeFormatString = 'EEE, MMM d, yyyy h:mm:ss a';
const String dayDisplayFormat = 'dd';
const String monthDisplayFormat = 'MMMM';
const String timeFormatString = 'h:mm:ss a';
const String timeText = 'Time';
const String timeWidgetSeperator = ':';
const Widget setWidget = const AutoSizeText('SET');
const double dayWidgetFactor = 4.6;
const double emptyOpacity = 0.0;
const double fontSize = 400.0;
const double fullOpacity = 1.0;
const double headerFontSize = 8.0;
const double headerWidgetFactor = 3.0;
const double minimalFontSize = 22.0;
const double monthWidgetFactor = 2.1;
const double overUnderOpacity = 0.4;
const double popoverArrowHeight = 10.0;
const double popoverArrowWidth = 30.0;
const double scrollWheelExtent = 0.25;
const double scrollWidgetMagnification = 1.1;
const double segmentButtonFactor = 3.5;
const double timeSeperatorWidthFactor = 0.03225806452;
const double timeWidgetWidthFactor = 0.2258064516;
const double yearWidgetFactor = 3.6;
const int amIndex = 0;
const int baseYear = 1600;
const int hourMinuteInfiniteWheelOffset = 360;
const int infiniteWheelFactor = 10;
const int midnight = 0;
const int minutesSecondsInfiniteWheelOffset = 300;
const int monthInfiniteWheelOffset = 120; //10 X (12 Months)
const int monthsInYear = 12;
const int noon = 12;
const int noonOrMidnight = 12;
const int pmIndex = 1;
const int yearLimit = 600;

TextStyle textStyle({required BuildContext context, TextStyle? textStyle}) => (textStyle ?? TextStyle()).copyWith(
      color: ThemeManager.color(characterColors, context: context),
      fontSize: fontSize,
    );

const String captionColors = 'com.icodeforyou.captionColors';
const String characterColors = 'com.icodeforyou.textColors';
const String dateColors = 'com.icodeforyou.com.dateColors';
const String timeColors = 'com.icodeforyou.com.timeColors';

class DateTimePickerConstants {
  DateTimePickerConstants() {
    ThemeColors captionWidget = ThemeColors(
      dark: Color(0xff7990ff),
      light: Colors.red,
    );
    ThemeColors textColors = ThemeColors(dark: Colors.white70, light: Colors.black87);
    ThemeColors dateWidget = ThemeColors(
      dark: Color(0xff0047ab),
      light: Color(0xffcccccc),
    );
    ThemeColors timeWidget = ThemeColors(
      dark: Color(0xff5a77e3),
      light: Color(0xffeeeeee),
    );
    ThemeManager.defaultThemeColors(captionWidget, forKey: captionColors);
    ThemeManager.defaultThemeColors(textColors, forKey: characterColors);
    ThemeManager.defaultThemeColors(dateWidget, forKey: dateColors);
    ThemeManager.defaultThemeColors(timeWidget, forKey: timeColors);
  }
}
