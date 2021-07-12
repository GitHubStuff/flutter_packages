import 'package:app_exception/app_exception.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../flutter_extras.dart';

class CannotParseThemeModeFromString extends AppException {
  CannotParseThemeModeFromString([String message = 'Invalid String', int code = 796])
      : super(
          message,
          'Cannot Read ThemeMode',
          code,
        );
}

extension StringExtensions on String {
  bool get isEmail => RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(this);

  static String composeDateTimeItems(Set<DateTimeElement> items) {
    if (items.isEmpty) return '--------';
    String result = (items.contains(DateTimeElement.year)) ? '+' : '-';
    result += (items.contains(DateTimeElement.month)) ? '+' : '-';
    result += (items.contains(DateTimeElement.day)) ? '+' : '-';
    result += (items.contains(DateTimeElement.hour)) ? '+' : '-';
    result += (items.contains(DateTimeElement.minute)) ? '+' : '-';
    result += (items.contains(DateTimeElement.second)) ? '+' : '-';
    result += (items.contains(DateTimeElement.millisecond)) ? '+' : '-';
    result += (items.contains(DateTimeElement.microsecond)) ? '+' : '-';
    return result;
  }

  Set<DateTimeElement> get elements {
    assert(this.length == DateTimeElement.values.length, '$this must be ${DateTimeElement.values.length}');
    assert(this.replaceAll(this, '+').replaceAll(this, '-').isNotEmpty, 'Invalid character is $this');
    Set<DateTimeElement> result = {};
    if (this.substring(0, 1) == '+') result.add(DateTimeElement.year);
    if (this.substring(1, 2) == '+') result.add(DateTimeElement.month);
    if (this.substring(2, 3) == '+') result.add(DateTimeElement.day);
    if (this.substring(3, 4) == '+') result.add(DateTimeElement.hour);
    if (this.substring(4, 5) == '+') result.add(DateTimeElement.minute);
    if (this.substring(5, 6) == '+') result.add(DateTimeElement.second);
    if (this.substring(6, 7) == '+') result.add(DateTimeElement.microsecond);
    if (this.substring(7, 8) == '+') result.add(DateTimeElement.millisecond);
    return result;
  }

  static String get uniqueKey => Uuid().v4();

  String scrub([String items = ' \t\n', String replace = '']) {
    List<String> tokens = items.split('');
    String tmp = this;
    tokens.forEach((chr) => tmp = tmp.replaceAll(chr, replace));
    return tmp;
  }

  DateTime get sqlite => DateTime.parse(this);

  ThemeMode asThemeMode() {
    ThemeMode? themeType = EnumToString.fromString<ThemeMode>(ThemeMode.values, this.toLowerCase());
    if (themeType == null) throw CannotParseThemeModeFromString('Cannot read/parse "$this" as ThemeMode {system, light, dark}', 801);
    return themeType;
  }
}
