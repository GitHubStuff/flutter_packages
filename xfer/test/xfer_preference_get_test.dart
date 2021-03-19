import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:xfer/xfer.dart';

//import 'package:tracers/tracers.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  Xfer xfer = Xfer(httpPostFuture: http.post);

  setUp(() {
    xfer = Xfer(httpPostFuture: http.post);
  });

  group('xfer.get("preference://key, {value: Object}")', () {
    test('test "preference://" - with missing key', () async {
      final Either<XferFailure, XferResponse> result = await xfer.get(
        'preference://',
        value: null,
      );
      result.fold(
        (err) {
          expect(err, isNotNull);
          expect(err.xferException, XferException.preferenceMissingKey);
        },
        (r) {
          expect(r, isNotNull);
          debugPrint('body => ${r.body}');
        },
      );
    });

    test('test "preference://dataKey", get non-existant preference and no default', () async {
      final Either<XferFailure, XferResponse> result = await xfer.get(
        'preference://dataKey',
        value: null,
      );
      result.fold(
        (err) {
          expect(err, isNull);
        },
        (r) {
          expect(r, isNotNull);
          expect(r.response, isNull);
          debugPrint('body => ${r.body}');
        },
      );
    });

    test('test "preference://dataKey, value:"DEFAULT", get non-existant preference with default String', () async {
      final Either<XferFailure, XferResponse> result = await xfer.get(
        'preference://dataKeyA',
        value: 'DEFAULT',
      );
      result.fold(
        (err) {
          expect(err, isNull);
        },
        (r) {
          expect(r, isNotNull);
          expect(r.body is String, true);
          expect(r.body is double, false);
          expect(r.body is bool, false);
          expect(r.body is int, false);
          expect(r.body as String, 'DEFAULT');
          debugPrint('response: ${r.toString()}');
        },
      );
    });

    test('test "preference://dataKey, value:false", get non-existant preference with default bool', () async {
      final Either<XferFailure, XferResponse> result = await xfer.get(
        'preference://dataKeyB',
        value: false,
      );
      result.fold(
        (err) {
          expect(err, isNull);
        },
        (r) {
          expect(r, isNotNull);
          expect(r.body is String, false);
          expect(r.body is double, false);
          expect(r.body is bool, true);
          expect(r.body is int, false);
          expect(r.body as bool, false);
          debugPrint('response: ${r.toString()}');
        },
      );
    });

    test('test "preference://dataKey, value:18.4", get non-existant preference with default double', () async {
      final Either<XferFailure, XferResponse> result = await xfer.get(
        'preference://dataKeyC',
        value: 18.4,
      );
      result.fold(
        (err) {
          expect(err, isNull);
        },
        (r) {
          expect(r, isNotNull);
          expect(r.body is String, false);
          expect(r.body is double, true);
          expect(r.body is bool, false);
          expect(r.body is int, false);
          expect(r.body as double, 18.4);
          debugPrint('response: ${r.toString()}');
        },
      );
    });

    test('test "preference://dataKey, value:607", get non-existant preference with default int', () async {
      final Either<XferFailure, XferResponse> result = await xfer.get(
        'preference://dataKeyD',
        value: 607,
      );
      result.fold(
        (err) {
          expect(err, isNull);
        },
        (r) {
          expect(r, isNotNull);
          expect(r.body is String, false);
          expect(r.body is double, false);
          expect(r.body is bool, false);
          expect(r.body is int, true);
          expect(r.body as int, 607);
          debugPrint('response: ${r.toString()}');
        },
      );
    });
  });
}
