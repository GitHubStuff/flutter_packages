import 'package:enum_to_string/enum_to_string.dart';

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
}
