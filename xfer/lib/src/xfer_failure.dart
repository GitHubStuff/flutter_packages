import 'package:enum_to_string/enum_to_string.dart';
import 'package:equatable/equatable.dart';

import '../xfer.dart';

class XferFailure extends Equatable implements Exception {
  final XferException xferException;
  final Object? code;
  const XferFailure(this.xferException, {this.code});

  List<Object?> get props => [xferException, code];

  String message() {
    if (code is int) return '${code as int}';
    if (code is String) return '${code as String}';
    return 'No Message';
  }

  String toString() => 'XFR code: ${message()}, xferException: ${EnumToString.convertToString(xferException)}';
}
