import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../xfer.dart';
import 'xfer_response.dart';

Future<Either<XferFailure, XferResponse>> _httpMethod(
  HttpVerb verb,
  String url, {
  required Object? body,
  required Encoding? encoding,
  required dynamic method,
  required Map<String, String>? headers,
  required XferProtocol protocol,
  required bool trace,
}) async {
  final Uri uri = Uri.parse(url);
  try {
    http.Response? response;
    String traceMessage;
    switch (verb) {
      case HttpVerb.GET:
        traceMessage = 'GET $url';
        response = await (method as Get)(uri, headers: headers);
        break;
      case HttpVerb.POST:
        traceMessage = 'POST $url';
        response = await (method as Post)(uri, headers: headers, body: body, encoding: encoding);
        break;
      case HttpVerb.PUT:
        traceMessage = 'PUT $url';
        response = await (method as Put)(uri, headers: headers, body: body, encoding: encoding);
        break;
    }
    final String responseInPlainText = '${response.statusCode} ${response.body.toString().substring(1, 20)}';
    if (trace) {
      debugPrint('🔍🔍 $traceMessage');
      debugPrint('🔭🔭 $responseInPlainText');
    }
    switch (response.statusCode) {
      case 200:
      case 201:
        final result = XferResponse(
          response.body,
          response.statusCode,
          protocol: protocol,
          response: response,
        );
        return Right(result);
      case 400:
        return Left(XferFailure(XferException.http400BadRequest, code: responseInPlainText));
      case 401:
        return Left(XferFailure(XferException.http401UnauthorizedException, code: responseInPlainText));
      case 403:
        return Left(XferFailure(XferException.http403UnauthorizedException, code: responseInPlainText));
      default:
        return Left(XferFailure(XferException.http500FetchDataException, code: responseInPlainText));
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
  String url, {
  Map<String, String>? headers,
  required Get getMethod,
  required XferProtocol protocol,
  required bool trace,
}) async =>
    _httpMethod(
      HttpVerb.GET,
      url,
      method: getMethod,
      protocol: protocol,
      headers: headers,
      encoding: null,
      body: null,
      trace: trace,
    );

Future<Either<XferFailure, XferResponse>> httpPost(
  String url, {
  required Map<String, String>? headers,
  required Object? body,
  required Encoding? encoding,
  required Post postMethod,
  required XferProtocol protocol,
  required bool trace,
}) async =>
    _httpMethod(
      HttpVerb.POST,
      url,
      method: postMethod,
      protocol: protocol,
      body: body,
      encoding: encoding,
      headers: headers,
      trace: trace,
    );

Future<Either<XferFailure, XferResponse>> httpPut(
  String url, {
  required Map<String, String>? headers,
  required Object? body,
  required Encoding? encoding,
  required Put putMethod,
  required XferProtocol protocol,
  required bool trace,
}) async =>
    _httpMethod(
      HttpVerb.PUT,
      url,
      method: putMethod,
      protocol: protocol,
      body: body,
      encoding: encoding,
      headers: headers,
      trace: trace,
    );
