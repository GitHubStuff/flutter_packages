library xfer;

import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:tracers_package/tracers.dart';
import 'package:xfer/src/xfer_hive.dart';

import 'src/xfer_asset.dart';
import 'src/xfer_cached.dart';
import 'src/xfer_failure.dart';
import 'src/xfer_http.dart';
import 'src/xfer_protocol_extension.dart';
import 'src/xfer_response.dart';

export 'src/cached_header.dart';
export 'src/xfer_failure.dart';
export 'src/xfer_response.dart';
export 'src/xfer_uri_dto.dart';

enum HttpVerb {
  GET,
  POST,
  PUT,
}

enum XferException {
  assetArguementError,
  assetReadError,
  assetWriteError,
  headerMissingContentType,
  headersMissing,
  headersMissingRequiredValues,
  headerUnknownContentType,
  http400BadRequest,
  http401UnauthorizedException,
  http403UnauthorizedException,
  http500FetchDataException,
  httpArguementError,
  httpSocketException, // Device not connected to internet, or permissions not set.
  httpUndefinedGETMethod,
  httpUndefinedPOSTMethod,
  httpUndefinedPUTMethod,
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
  cachedImage,
}

/// Standard http.post for actual HTTP calls (the library/package used eg: package:http/http.dart')
typedef Future<Response> Post(Uri url, {Map<String, String>? headers, Object? body, Encoding? encoding});
typedef Future<Response> Put(Uri url, {Map<String, String>? headers, Object? body, Encoding? encoding});
typedef Future<Response> Get(Uri url, {Map<String, String>? headers});

typedef void CachedImageError(dynamic message);

class Xfer {
  final Post? httpPostFuture;
  final Put? httpPutFuture;
  final Get? httpGetFuture;
  final bool trace;
  // NOTE: Constructor
  const Xfer({
    this.httpGetFuture,
    this.httpPostFuture,
    this.httpPutFuture,
    this.trace = false,
  });

  // FETCH - Non-async GET for cachedImages
  Either<XferFailure, XferResponse> fetch(String url, {required Map<String, String> headers, Object? imageError}) =>
      cachedGet(url, headers: headers, cachedImageError: imageError == null ? null : imageError as CachedImageError);

  /// GET
  Future<Either<XferFailure, XferResponse>> get(
    String url, {
    Map<String, String>? headers,
    Object? value,
  }) async {
    TimeMarker? tm;
    if (trace) {
      tm = TimeMarker('🟠 GET url: $url');
      if (headers != null) debugPrint(' ⛓ headers:${headers.toString()}');
      if (value != null) debugPrint(' 💡 value:${value.toString()}');
    }
    try {
      XferProtocol protocol = XferProtocolExtension.protocol(url);
      switch (protocol) {
        case XferProtocol.cachedImage:
          Either<XferFailure, XferResponse> cachedResponse = fetch(url, headers: headers!, imageError: value);
          tm?.show('$url');
          return cachedResponse;
        case XferProtocol.asset:
          Either<XferFailure, XferResponse> assetResponse = await assetGet(url, headers: headers);
          tm?.show('$url');
          return assetResponse;
        case XferProtocol.http:
        case XferProtocol.https:
          if (httpGetFuture == null) throw XferException.httpUndefinedGETMethod;
          Either<XferFailure, XferResponse> getResponse = await httpGet(
            url,
            headers: headers,
            getMethod: httpGetFuture!,
            protocol: protocol,
          );
          tm?.show('🟠 GOT $url');
          return getResponse;

        case XferProtocol.pref:
        case XferProtocol.preference:
          Either<XferFailure, XferResponse> hiveResponse = await hiveGet(url, value: value);
          tm?.show('🟠 GOT $url');
          return hiveResponse;
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
      TimeMarker? tm;
      if (trace) {
        tm = TimeMarker('🟩 POST url: $url');
        if (headers != null) debugPrint(' ⛓ headers:${headers.toString()}');
        if (body != null) debugPrint(' 📦 body:${body.toString()}');
        if (value != null) debugPrint(' 💡 value:${value.toString()}');
        if (encoding != null) debugPrint(' 🔑 encoding:${encoding.toString()}');
      }
      XferProtocol protocol = XferProtocolExtension.protocol(url);
      switch (protocol) {
        case XferProtocol.cachedImage:
          return fetch(url, headers: headers!, imageError: value);
        case XferProtocol.asset:
          return Left(XferFailure(XferException.invalidXferRequest, code: 'POST not available for asset://'));
        case XferProtocol.http:
        case XferProtocol.https:
          if (httpPostFuture == null) throw XferException.httpUndefinedPOSTMethod;
          Either<XferFailure, XferResponse> httpResponse = await httpPost(
            url,
            headers: headers,
            body: body,
            encoding: encoding,
            postMethod: httpPostFuture!,
            protocol: protocol,
          );
          tm?.show('🟩 POSTED $url');
          return httpResponse;
        case XferProtocol.pref:
        case XferProtocol.preference:
          return hivePost(url, value: body ?? value);
      }
    } catch (error) {
      return Left(error as XferFailure);
    }
  }

  /// PUT
  Future<Either<XferFailure, XferResponse>> put(
    String url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
    Object? value,
  }) async {
    try {
      TimeMarker? tm;
      if (trace) {
        tm = TimeMarker('🟣 PUT url: $url');
        if (headers != null) debugPrint(' ⛓ headers:${headers.toString()}');
        if (body != null) debugPrint(' 📦 body:${body.toString()}');
        if (value != null) debugPrint(' 💡 value:${value.toString()}');
        if (encoding != null) debugPrint(' 🔑 encoding:${encoding.toString()}');
      }
      XferProtocol protocol = XferProtocolExtension.protocol(url);
      switch (protocol) {
        case XferProtocol.cachedImage:
          return get(url, headers: headers, value: value);
        case XferProtocol.asset:
          return Left(XferFailure(XferException.invalidXferRequest, code: 'PUT not available for asset://'));
        case XferProtocol.http:
        case XferProtocol.https:
          if (httpPutFuture == null) throw XferException.httpUndefinedPUTMethod;
          Either<XferFailure, XferResponse> putResponse = await httpPut(
            url,
            headers: headers,
            body: body,
            encoding: encoding,
            putMethod: httpPutFuture!,
            protocol: protocol,
          );
          tm?.show('🟣 PUT $url\n');
          return putResponse;
        case XferProtocol.pref:
        case XferProtocol.preference:
          return hivePost(url, value: body ?? value);
      }
    } catch (error) {
      return Left(error as XferFailure);
    }
  }
}
