import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:xfer/xfer.dart';

bool _isInitialized = false;
Map<String, Object> _privatePref = Map();
enum PreferenceDataType {
  boolean,
  double,
  integer,
  string,
}

Future<Either<XferFailure, XferResponse>> hiveGet(String url, {Object? value}) async {
  final String key = url.split('://').last;
  if (key.isEmpty) return Left(XferFailure(XferException.preferenceMissingKey, code: 'Missing key'));
  final DateTime startRequest = DateTime.now().toUtc();

  try {
    if (!_isInitialized) await Hive.initFlutter();
    _isInitialized = true;
  } on NullThrownError {
    final result = _privatePref[key] ?? value;
    Duration duration = DateTime.now().toUtc().difference(startRequest);
    return Right(XferResponse(result, 200, protocol: XferProtocol.preference, duration: duration));
  } on MissingPluginException {
    final result = _privatePref[key] ?? value;
    Duration duration = DateTime.now().toUtc().difference(startRequest);
    return Right(XferResponse(result, 200, protocol: XferProtocol.preference, duration: duration));
  }

  var box = await Hive.openBox(key);
  final result = box.get(key, defaultValue: value);
  Duration duration = DateTime.now().toUtc().difference(startRequest);
  return Right(XferResponse(result, 200, protocol: XferProtocol.preference, duration: duration));
}

Future<Either<XferFailure, XferResponse>> hivePost(String url, {Object? value}) async {
  final String key = url.split('://').last;
  if (key.isEmpty) return Left(XferFailure(XferException.preferenceMissingKey, code: 'Missing key'));
  final DateTime startRequest = DateTime.now().toUtc();
  if (value == null) return Left(XferFailure(XferException.preferenceMissingData));

  try {
    if (!_isInitialized) await Hive.initFlutter();
    _isInitialized = true;
  } on NullThrownError {
    final result = _privatePref[key] ?? value;
    Duration duration = DateTime.now().toUtc().difference(startRequest);
    return Right(XferResponse(result, 200, protocol: XferProtocol.preference, duration: duration));
  } on MissingPluginException {
    final result = _privatePref[key] ?? value;
    Duration duration = DateTime.now().toUtc().difference(startRequest);
    return Right(XferResponse(result, 200, protocol: XferProtocol.preference, duration: duration));
  }

  var box = await Hive.openBox(key);
  PreferenceDataType? type = _getType(value);
  switch (type) {
    case PreferenceDataType.boolean:
      box.put(key, value as bool);
      break;
    case PreferenceDataType.double:
      box.put(key, value as double);
      break;
    case PreferenceDataType.integer:
      box.put(key, value as int);
      break;
    case PreferenceDataType.string:
      box.put(key, value as String);
      break;
    default:
      return Left(XferFailure(XferException.preferenceUnknownDataType, code: 'body: ${value.toString()}'));
  }
  final Duration duration = DateTime.now().toUtc().difference(startRequest);
  return Right(XferResponse(true, 201, protocol: XferProtocol.preference, duration: duration));
}

PreferenceDataType? _getType(Object value) {
  if (value is bool) return PreferenceDataType.boolean;
  if (value is double) return PreferenceDataType.double;
  if (value is int) return PreferenceDataType.integer;
  if (value is String) return PreferenceDataType.string;
  return null;
}
