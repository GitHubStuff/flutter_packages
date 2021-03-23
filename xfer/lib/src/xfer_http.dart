import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../xfer.dart';
import 'xfer_response.dart';

enum httpVerb {
  GET,
  POST,
  PUT,
}

Future<Either<XferFailure, XferResponse>> _httpMethod(
  httpVerb verb,
  Uri uri, {
  Object? body,
  Encoding? encoding,
  required dynamic method,
  Map<String, String>? headers,
  required XferProtocol protocol,
}) async {
  try {
    if (method == null) return Left(XferFailure(XferException.httpUndefinedMethod));
    http.Response? response;
    final DateTime startRequest = DateTime.now().toUtc();
    switch (verb) {
      case httpVerb.GET:
        response = await (method as Get)(uri, headers: headers);
        break;
      case httpVerb.POST:
        response = await (method as Post)(uri, headers: headers, body: body, encoding: encoding);
        break;
      case httpVerb.PUT:
        return Left(XferFailure(XferException.httpUndefinedMethod, code: 'PUT not implemented'));
    }
    final Duration duration = DateTime.now().toUtc().difference(startRequest);
    switch (response.statusCode) {
      case 200:
      case 201:
        final result = XferResponse(
          response.body,
          response.statusCode,
          protocol: protocol,
          response: response,
          duration: duration,
        );
        return Right(result);
      case 400:
        return Left(XferFailure(XferException.http400BadRequest));
      case 401:
        return Left(XferFailure(XferException.http401UnauthorizedException));
      case 403:
        return Left(XferFailure(XferException.http403UnauthorizedException));
      default:
        return Left(XferFailure(XferException.http500FetchDataException, code: response.statusCode));
    }
  } on ArgumentError {
    return Left(XferFailure(XferException.httpArguementError));
  } on SocketException catch (e) {
    /// On [Android] devices SocketException can occur because:
    /// 1 - The device is not connected to the internet {WiFi/Wired}
    /// 2 - The [AndroidManifest.xml] file is missing: <uses-permission android:name="android.permission.INTERNET"/>
    /// 3 - Server timeout from bad url
    debugPrint('❌ SocketException uri:${uri.toString()}, check network connection and/or app permissions');
    return Left(XferFailure(XferException.httpSocketException, code: e.toString()));
  }
}

Future<Either<XferFailure, XferResponse>> httpGet(
  Uri uri, {
  Map<String, String>? headers,
  required Get? getMethod,
  required XferProtocol protocol,
}) async =>
    _httpMethod(httpVerb.GET, uri, method: getMethod, protocol: protocol, headers: headers);

Future<Either<XferFailure, XferResponse>> httpPost(
  Uri uri, {
  Map<String, String>? headers,
  Object? body,
  Encoding? encoding,
  required Post? postMethod,
  required XferProtocol protocol,
}) async =>
    _httpMethod(
      httpVerb.POST,
      uri,
      method: postMethod,
      protocol: protocol,
      body: body,
      encoding: encoding,
      headers: headers,
    );
