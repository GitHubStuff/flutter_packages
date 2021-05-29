//Copyright 2021, LTMM LLC
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:theme_management_package/theme_management_package.dart';

const Duration crossFadeDuration = const Duration(milliseconds: 400);
const EdgeInsets padding = EdgeInsets.all(4.0);
const EdgeInsets seperatorPadding = EdgeInsets.only(top: 4, bottom: 4);
const Size minimalPickerSize = const Size(280.0, 150.0);
const Size minimalPopoverSize = const Size(280.0, 237.5);
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
const double headerFontSize = 18.0;
const double headerWidgetFactor = 3.0;
const double minimalFontSize = 22.0;
const double monthWidgetFactor = 2.1;
const double overUnderOpacity = 0.4;
const double popoverArrowHeight = 10.0;
const double popoverArrowWidth = 30.0;
const double scrollWheelExtent = 0.25;
const double scrollWidgetMagnification = 1.1;
const double segmentButtonFactor = 4.0;
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

TextStyle headerTextStyle(Brightness brightness, {required BuildContext context}) => TextStyle().copyWith(
      color: ThemeCubit.colorOf(headerTextColors, context: context),
      fontWeight: FontWeight.bold,
    );

const String _datePickerColors = 'com.icodeforyou.datePickerColors';
const String headerTextColors = 'com.icodeforyou.headerTextColors';
const String pickerColors = 'com.icodeforyou.pickerColors';
const String pickerTextColors = 'com.icodeforyou.pickerTextColors';
const String setButtonColors = 'com.icodeforyou.setButtonColors';
const String timePickerColors = 'com.icodeforyou.timePickerColors';

class DateTimePickerConstants {
  DateTimePickerConstants() {
    ThemeColorsManager.add(key: _datePickerColors, dark: Color(0xFF004D40), light: Color(0xFFBDBDBD));
    ThemeColorsManager.add(key: headerTextColors, dark: Colors.white60, light: Colors.black87);
    ThemeColorsManager.add(key: pickerColors, dark: Colors.black87, light: Colors.white70);
    ThemeColorsManager.add(key: pickerTextColors, dark: Colors.white70, light: Colors.black87);
    ThemeColorsManager.add(key: setButtonColors, dark: Colors.white54, light: Colors.black54);
    ThemeColorsManager.add(key: timePickerColors, dark: Color(0xFF00796B), light: Color(0xFFE0E0E0));
  }
}
