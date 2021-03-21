import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../xfer.dart';

enum PreferenceDataType {
  boolean,
  float,
  integer,
  string,
}

Map<String, Object> _privatePref = Map();

Future<Either<XferFailure, XferResponse>> preferenceGet(
  String url, {
  Object? value,
}) async {
  final String key = url.split('://').last;
  if (key.isEmpty) return Left(XferFailure(XferException.preferenceMissingKey, code: 'Missing key'));
  final DateTime startRequest = DateTime.now().toUtc();
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final result = prefs.get(key) ?? value;
    Duration duration = DateTime.now().toUtc().difference(startRequest);
    return Right(XferResponse(result, 200, protocol: XferProtocol.preference, duration: duration));
  } on MissingPluginException {
    final result = _privatePref[key] ?? value;
    Duration duration = DateTime.now().toUtc().difference(startRequest);
    return Right(XferResponse(result, 200, protocol: XferProtocol.preference, duration: duration));
  }
}

Future<Either<XferFailure, XferResponse>> preferencePost(
  String url, {
  Object? value,
}) async {
  final String key = url.split('://').last;
  if (key.isEmpty) return Left(XferFailure(XferException.preferenceMissingKey, code: 'Missing key'));

  if (value == null) return Left(XferFailure(XferException.preferenceMissingData));

  final DateTime startRequest = DateTime.now().toUtc();
  PreferenceDataType? type = _getType(value);
  if (value is bool) type = PreferenceDataType.boolean;
  if (value is double) type = PreferenceDataType.float;
  if (value is int) type = PreferenceDataType.integer;
  if (value is String) type = PreferenceDataType.string;
  if (type == null) return Left(XferFailure(XferException.preferenceUnknownDataType, code: 'body: ${value.toString()}'));

  bool isSet = false;
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    switch (type) {
      case PreferenceDataType.boolean:
        isSet = await prefs.setBool(key, value as bool);
        break;
      case PreferenceDataType.float:
        isSet = await prefs.setDouble(key, value as double);
        break;
      case PreferenceDataType.integer:
        isSet = await prefs.setInt(key, value as int);
        break;
      case PreferenceDataType.string:
        isSet = await prefs.setString(key, value as String);
        break;
    }
  } on MissingPluginException {
    _privatePref[key] = value;
    final Duration duration = DateTime.now().toUtc().difference(startRequest);
    return Right(XferResponse(true, 201, protocol: XferProtocol.preference, duration: duration));
  }

  if (!isSet)
    return Left(
      XferFailure(XferException.preferenceNotSet, code: 'Shared Preference returned false'),
    );
  final Duration duration = DateTime.now().toUtc().difference(startRequest);
  return Right(XferResponse(isSet, 201, protocol: XferProtocol.preference, duration: duration));
}

PreferenceDataType? _getType(Object value) {
  if (value is bool) return PreferenceDataType.boolean;
  if (value is double) return PreferenceDataType.float;
  if (value is int) return PreferenceDataType.integer;
  if (value is String) return PreferenceDataType.string;
  return null;
}
