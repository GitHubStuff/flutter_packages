//Copyright 2021, LTMM LLC
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:theme_management_package/theme_management_package.dart';

const CustomColor datePickerColor = const CustomColor(dark: Color(0xFF004D40), light: Color(0xFFBDBDBD));
const CustomColor timePickerColor = const CustomColor(dark: Color(0xFF00796B), light: Color(0xFFE0E0E0));
const CustomColor pickerColor = const CustomColor(dark: Colors.black87, light: Colors.white70);
const CustomColor headerTextColor = const CustomColor(dark: Colors.white60, light: Colors.black87);
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
const double dayWidgetFactor = 4.6;
const double emptyOpacity = 0.0;
const double fontSize = 400.0;
const double fullOpacity = 1.0;
const double headerFontSize = 18.0;
const double headerWidgetFactor = 3.0;
const double minimalFontSize = 22.0;
const double monthWidgetFactor = 2.1;
const double scrollWheelExtent = 0.25;
const double segmentButtonFactor = 4.0;
const double yearWidgetFactor = 3.6;
const int amIndex = 0;
const int baseYear = 1600;
const int infiniteWheelFactor = 10;
const int midnight = 0;
const int monthInfiniteWheelOffset = 120; //10 X (12 Months)
const int monthsInYear = 12;
const int noon = 12;
const int noonOrMidnight = 12;
const int pmIndex = 1;
const int yearLimit = 600;
const double popoverArrowHeight = 10.0;
const double popoverArrowWidth = 30.0;
const int hourMinuteInfiniteWheelOffset = 360;
const int minutesSecondsInfiniteWheelOffset = 300;
const double timeWidgetWidthFactor = 0.2258064516;
const double timeSeperatorWidthFactor = 0.03225806452;
const String timeWidgetSeperator = ':';
const double scrollWidgetMagnification = 1.1;
const double overUnderOpacity = 0.4;
const Widget setWidget = const AutoSizeText('SET');

TextStyle headerTextStyle(Brightness brightness) => TextStyle().copyWith(
      color: headerTextColor.of(brightness),
      fontWeight: FontWeight.bold,
    );
