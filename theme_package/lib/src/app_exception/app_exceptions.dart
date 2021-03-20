// Copyright 2020 LTMM. All rights reserved.
// Uses of this source code is governed by 'The Unlicense' that can be
// found in the LICENSE file.

import 'app_exception.dart';

class UnknownBrightnessType extends AppException {
  UnknownBrightnessType([String message, int code]) : super(message, 'Unknow Brightness value', code);
}

/// These are extensions to [AppException] for the different kind of exceptions that
/// can occur when developing/running the [theme_package]

class UnknownThemeMode extends AppException {
  UnknownThemeMode([String message, int code]) : super(message, 'Unknown ThemeMode', code);
}

class UnknownThemeProperty extends AppException {
  UnknownThemeProperty([String message, int code]) : super(message, 'Unknown Theme Property', code);
}

class UnknownThemeType extends AppException {
  UnknownThemeType([String message, int code]) : super(message, 'Unknown ThemeType', code);
}
