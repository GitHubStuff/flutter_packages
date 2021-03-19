import 'package:app_exception/app_exception.dart';

class InvalidText implements AppException {
  final String message;
  final Object prefix;
  final int code;
  InvalidText([this.message = '', this.prefix = '', this.code = 0]);

  String toString() {
    return '{"$prefix" : $message", "code":$code}';
  }

  List<Object> get props => [message, prefix, code];

  @override
  bool? get stringify => null;
}
