/// Copyright 2021, LTMM
library json_decoder;

import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:tracers_package/tracers.dart';

typedef dynamic JsonDecoding(String source, {Object? reviver(Object? key, Object? value)?});
JsonDecoding jsonDecoder = json.decode;

enum JsonDecodeType {
  list,
  map,
}

/// Gateway class with static method "decode" to parse/decode a json string
class JSONDecoder {
  static Either<T, JsonDecoded> decode<T extends Exception>(String data, {bool reportDecodingTime = false}) {
    try {
      final tm = TimeMarker();
      final JsonDecoded jsonDecoded = JsonDecoded(data);
      if (reportDecodingTime) tm.show('decoding:$data\n');
      return Right(jsonDecoded);
    } catch (error) {
      return Left(error as T);
    }
  }
}

/// Results of decoded json-String including json type(map or list), and time in milliseconds to perform download,
/// and accessors (jsonMap and jsonList) for decoded values according to type.
class JsonDecoded {
  final String source;
  dynamic result;

  JsonDecoded(this.source) {
    result = jsonDecoder(source);
  }

  List<Map<String, dynamic>>? get jsonConvertListDynamic => (result == null) ? null : (result as List).map((e) => e as Map<String, dynamic>).toList();

  Map<String, dynamic>? get jsonMap => (result == null || result is List) ? null : result as Map<String, dynamic>;

  List<Map<String, dynamic>>? get jsonList => (result == null || result is Map) ? null : result as List<Map<String, dynamic>>;

  JsonDecodeType? get jsonType => (result == null)
      ? null
      : (result is List)
          ? JsonDecodeType.list
          : JsonDecodeType.map;

  String toString() {
    final String type = (jsonType == null) ? 'type: null' : 'type: ${EnumToString.convertToString(jsonType)}';
    return '$type\nsource:$source';
  }
}
