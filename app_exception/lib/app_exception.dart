// Copyright 2021 LTMM.
library app_exception;

import 'package:equatable/equatable.dart';

abstract class AppException extends Equatable implements Exception {
  final message;
  final title;
  final code;
  AppException([this.message, this.title, this.code]);

  String toString() {
    return '🛑 $title : $message\n🛑 code : $code';
  }

  List<Object> get props => [message, title, code];
}
