import 'dart:convert';

import 'package:dartz/dartz.dart';

import '../xfer.dart';

abstract class XferModel {
  Future<Either<XferFailure, XferResponse>> post(
    String url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  });
}
