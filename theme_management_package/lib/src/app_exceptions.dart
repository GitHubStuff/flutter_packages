import 'package:app_exception/app_exception.dart';

class CannotReadThemeMode extends AppException {
  CannotReadThemeMode([String message = '', int code = 11]) : super(message, 'Cannot Read Pref for Theme', code);
}

class CannotSetTheme extends AppException {
  CannotSetTheme([String message = '', int code = 12]) : super(message, 'Cannot Set Theme', code);
}

class DuplicateColor extends AppException {
  DuplicateColor([String message = 'Duplicate color found!', int code = 44]) : super(message, 'Duplicate color');
}

class EmptyKey extends AppException {
  EmptyKey([String message = 'Cannot have a blank/empty key', int code = 18]) : super(message, 'Blank Key');
}

class IncompleteThemeCubit extends AppException {
  IncompleteThemeCubit([String message = '', int code = 14]) : super(message, 'No call on ThemeCubit.setup()');
}

class RequiresContext extends AppException {
  RequiresContext([String message = 'Requires BuildContext to complete', int code = 40]) : super(message, 'Missing Context');
}

class UnknownColor extends AppException {
  UnknownColor([String message = '', int code = 15]) : super(message, 'Cannot find color');
}

class UnknownHiveException extends AppException {
  UnknownHiveException([String message = '', int code = 16]) : super(message, 'Unhandled HIVE exception');
}
