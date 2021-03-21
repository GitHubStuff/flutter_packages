import 'package:app_exception/app_exception.dart';

class UnknownBrightnessType extends AppException {
  UnknownBrightnessType([String message, int code]) : super(message, 'Unknow Brightness value', code);
}

class UnknownThemeMode extends AppException {
  UnknownThemeMode([String message, int code]) : super(message, 'Unknown ThemeMode', code);
}

class UnknownThemeProperty extends AppException {
  UnknownThemeProperty([String message, int code]) : super(message, 'Unknown Theme Property', code);
}

class UnknownThemeType extends AppException {
  UnknownThemeType([String message, int code]) : super(message, 'Unknown ThemeType', code);
}
