// Copyright 2020 LTMM. All rights reserved.
// Uses of this source code is governed by 'The Unlicense' that can be
// found in the LICENSE file.

// Create Exception classes by extending this class.
import 'package:equatable/equatable.dart';

/// - Examples: [see app_exceptions.dart]

class AppException extends Equatable implements Exception {
  final message;
  final prefix;
  final code;
  AppException([this.message, this.prefix, this.code]);

  String toString() {
    return '{"$prefix" : $message", "code":$code}';
  }

  List<Object> get props => [message, prefix, code];
}
