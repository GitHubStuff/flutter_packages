import 'package:app_exception/app_exception.dart';

class CannotReadThemeMode extends AppException {
  CannotReadThemeMode([String message = '', int code = 903]) : super(message, 'Cannot Read Pref for Theme', code);
}
