/// Copyright 2021, LTMM
library json_decoder;

import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:enum_to_string/enum_to_string.dart';

typedef dynamic JsonDecoding(String source, {Object? reviver(Object? key, Object? value)?});
JsonDecoding jsonDecoder = json.decode;

enum JsonDecodeType {
  list,
  map,
}

/// Gateway class with static method "decode" to parse/decode a json string
class JSONDecoder {
  static Either<Exception, JsonDecoded> decode(String data) {
    try {
      return Right(JsonDecoded(data));
    } catch (error) {
      return Left(error as Exception);
    }
  }
}

/// Results of decoded json-String including json type(map or list), and time in milliseconds to perform download,
/// and accessors (jsonMap and jsonList) for decoded values according to type.
class JsonDecoded {
  final String source;
  DateTime _startDecode = DateTime.now().toUtc();
  DateTime? _finishDecode;
  dynamic? result;
  JsonDecoded(this.source) {
    _startDecode = DateTime.now().toUtc();
    result = jsonDecoder(source);
    _finishDecode = DateTime.now().toUtc();
  }

  Duration? get duration => _finishDecode == null ? null : _finishDecode!.difference(_startDecode);
  Map<String, dynamic>? get jsonMap => (result == null || result is List) ? null : result as Map<String, dynamic>;
  List<Map<String, dynamic>>? get jsonList => (result is List) ? result as List<Map<String, dynamic>> : null;
  JsonDecodeType? get jsonType => (result == null)
      ? null
      : (result is List)
          ? JsonDecodeType.list
          : JsonDecodeType.map;

  String toString() {
    final String type = jsonType == null ? "type: null" : "type: ${EnumToString.convertToString(jsonType)}";
    final String decodeTime = "Decode: ${duration == null ? 'N/A' : duration!.inMilliseconds}/ms";
    return '$type, $decodeTime, source:$source';
  }
}
