library xfer;

import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:xfer/src/xfer_preference.dart';

import 'src/xfer_asset.dart';
import 'src/xfer_failure.dart';
import 'src/xfer_http.dart';
import 'src/xfer_protocol_extension.dart';
import 'src/xfer_response.dart';

export 'src/xfer_asset.dart';
export 'src/xfer_failure.dart';
export 'src/xfer_response.dart';

enum XferException {
  assetArguementError,
  assetReadError,
  headerMissingContentType,
  headerUnknownContentType,
  httpArguementError,
  httpSocketException, // Device not connected to internet, or permissions not set.
  httpUndefinedMethod,
  http400BadRequest,
  http401UnauthorizedException,
  http403UnauthorizedException,
  http500FetchDataException,
  invalidXferRequest,
  preferenceMissingData,
  preferenceMissingKey,
  preferenceNotSet,
  preferenceUnknownDataType,
  urlMissingProtocol,
  urlUnknownProtocol,
}

enum XferProtocol {
  asset,
  http,
  https,
  pref,
  preference,
}

/// Standard http.post for actual HTTP calls (the library/package used eg: package:http/http.dart')
typedef Future<Response> Post(Uri url, {Map<String, String>? headers, Object? body, Encoding? encoding});
typedef Future<Response> Put(Uri url, {Map<String, String>? headers, Object? body, Encoding? encoding});
typedef Future<Response> Get(Uri url, {Map<String, String>? headers});

class Xfer {
  final Post? _httpPostFuture;
  final Put? _httpPutFuture;
  final Get? _httpGetFuture;
  final bool _trace;
  // NOTE: Constructor
  const Xfer({Post? httpPostFuture, Put? httpPutFuture, Get? httpGetFuture, bool trace = false})
      : _httpPostFuture = httpPostFuture,
        _httpPutFuture = httpPutFuture,
        _httpGetFuture = httpGetFuture,
        _trace = trace;

  /// GET
  Future<Either<XferFailure, XferResponse>> get(
    String url, {
    Map<String, String>? headers,
    Object? value,
  }) async {
    if (_trace) {
      debugPrint('🔮 url: $url');
      if (headers != null) debugPrint('⛓ headers:${headers.toString()}');
      if (value != null) debugPrint('💡 value:${value.toString()}');
    }
    try {
      XferProtocol protocol = XferProtocolExtension.protocol(url);
      switch (protocol) {
        case XferProtocol.asset:
          return assetGet(url, headers: headers);
        case XferProtocol.http:
        case XferProtocol.https:
          return httpGet(
            url,
            headers: headers,
            getMethod: _httpGetFuture,
            protocol: protocol,
          );
        case XferProtocol.pref:
        case XferProtocol.preference:
          return preferenceGet(url, value: value);
      }
    } catch (error) {
      return Left(error as XferFailure);
    }
  }

  /// POST
  Future<Either<XferFailure, XferResponse>> post(
    String url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
    Object? value,
  }) async {
    try {
      if (_trace) {
        debugPrint('🔮 url: $url');
        if (headers != null) debugPrint('⛓ headers:${headers.toString()}');
        if (body != null) debugPrint('📦 body:${body.toString()}');
        if (value != null) debugPrint('💡 value:${value.toString()}');
        if (encoding != null) debugPrint('🔑 encoding:${encoding.toString()}');
      }
      XferProtocol protocol = XferProtocolExtension.protocol(url);
      switch (protocol) {
        case XferProtocol.asset:
          return assetPost(url, headers: headers);
        case XferProtocol.http:
        case XferProtocol.https:
          return httpPost(
            url,
            headers: headers,
            body: body,
            encoding: encoding,
            postMethod: _httpPostFuture,
            protocol: protocol,
          );
        case XferProtocol.pref:
        case XferProtocol.preference:
          return preferencePost(url, value: body ?? value);
      }
    } catch (error) {
      return Left(error as XferFailure);
    }
  }

  /// POST
  Future<Either<XferFailure, XferResponse>> put(
    String url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
    Object? value,
  }) async {
    try {
      if (_trace) {
        debugPrint('🔮 url: $url');
        if (headers != null) debugPrint('⛓ headers:${headers.toString()}');
        if (body != null) debugPrint('📦 body:${body.toString()}');
        if (value != null) debugPrint('💡 value:${value.toString()}');
        if (encoding != null) debugPrint('🔑 encoding:${encoding.toString()}');
      }
      XferProtocol protocol = XferProtocolExtension.protocol(url);
      switch (protocol) {
        case XferProtocol.asset:
          return Left(XferFailure(XferException.invalidXferRequest, code: 'Put not available for asset://'));
        case XferProtocol.http:
        case XferProtocol.https:
          return httpPut(
            url,
            headers: headers,
            body: body,
            encoding: encoding,
            putMethod: _httpPostFuture,
            protocol: protocol,
          );
        case XferProtocol.pref:
        case XferProtocol.preference:
          return preferencePost(url, value: body ?? value);
      }
    } catch (error) {
      return Left(error as XferFailure);
    }
  }
}
