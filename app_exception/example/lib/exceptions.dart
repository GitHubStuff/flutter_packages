import 'package:app_exception/app_exception.dart';

class InvalidText extends AppException {
  InvalidText([String message = '(invalid text)', int code = 7]) : super(message, 'Invalid Text', code);
}
