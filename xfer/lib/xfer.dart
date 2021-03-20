library xfer;

import 'dart:convert';

import 'package:dartz/dartz.dart';
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
typedef Future<Response> Get(Uri url, {Map<String, String>? headers});

class Xfer {
  final Post? httpPostFuture;
  final Get? httpGetFuture;
  // NOTE: Constructor
  const Xfer({
    this.httpPostFuture,
    this.httpGetFuture,
  });

  /// GET
  Future<Either<XferFailure, XferResponse>> get(
    String url, {
    Map<String, String>? headers,
    Object? value,
  }) async {
    try {
      XferProtocol protocol = await XferProtocolExtension.protocol(url);
      switch (protocol) {
        case XferProtocol.asset:
          return assetGet(url, headers: headers);
        case XferProtocol.http:
        case XferProtocol.https:
          return httpGet(
            Uri.parse(url),
            headers: headers,
            getMethod: httpGetFuture,
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
      XferProtocol protocol = await XferProtocolExtension.protocol(url);
      switch (protocol) {
        case XferProtocol.asset:
          return assetPost(url, headers: headers);
        case XferProtocol.http:
        case XferProtocol.https:
          return httpPost(
            Uri.parse(url),
            headers: headers,
            body: body,
            encoding: encoding,
            postMethod: httpPostFuture,
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
