import 'dart:typed_data';

import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';

import '../xfer.dart';

class XferResponse {
  final XferProtocol protocol;
  final dynamic body;
  final int statusCode;
  final dynamic response;
  XferResponse(
    this.body,
    this.statusCode, {
    required this.protocol,
    this.response,
  });

  T data<T>() => (body as T);

  String toString() => 'XferProtocol: ${EnumToString.convertToString(protocol)}, statusCode: $statusCode, response?: $response body: "$body"';

  Widget? asImage() {
    switch (protocol) {
      case XferProtocol.asset:
        return Image(image: body as AssetImage);
      case XferProtocol.cachedImage:
        return body as Widget;
      case XferProtocol.http:
      case XferProtocol.https:
        List<int> list = (body as String).codeUnits;
        Uint8List bytes = Uint8List.fromList(list);
        return Image.memory(bytes);
      default:
        return null;
    }
  }
}
