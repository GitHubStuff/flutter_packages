import 'package:enum_to_string/enum_to_string.dart';

import '../xfer.dart';

class XferResponse {
  final XferProtocol protocol;
  final dynamic body;
  final int statusCode;
  final Duration duration;
  final Object? response;
  XferResponse(this.body, this.statusCode, {required this.protocol, this.response, required this.duration});

  String toString() =>
      'XferProtocol: ${EnumToString.convertToString(protocol)}, statusCode: $statusCode, ⏱ duration: ${duration.inMilliseconds}/ms, response?: $response body: "$body"';
}
