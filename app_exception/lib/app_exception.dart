// Copyright 2021 LTMM.
library app_exception;

import 'package:equatable/equatable.dart';

abstract class AppException extends Equatable implements Exception {
  final message;
  final prefix;
  final code;
  AppException([this.message, this.prefix, this.code]);

  String toString() {
    return '{"$prefix" : $message", "code":$code}';
  }

  List<Object> get props => [message, prefix, code];
}
