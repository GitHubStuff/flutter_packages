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

  group('xfer.post("pref://", value: ?);', () {
    test('"pref://" -- post with missing Key', () async {
      final Either<XferFailure, XferResponse> result = await xfer.post(
        'preference://',
        headers: null,
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
    test('Test "pref://key" -- post Valid Data', () async {
      final Either<XferFailure, XferResponse> result = await xfer.post(
        'preference://savedInt',
        body: 12,
      );
      result.fold(
        (err) {
          expect(err, isNotNull);
          expect(err.xferException, XferException.preferenceMissingData);
        },
        (r) {
          expect(r, isNotNull);
          debugPrint('${r.toString()}');
        },
      );
    });

    test('Test "pref://key" -- post with missing data', () async {
      final Either<XferFailure, XferResponse> result = await xfer.post(
        'preference://missingData',
        body: null,
      );
      result.fold(
        (err) {
          expect(err, isNotNull);
          expect(err.xferException, XferException.preferenceMissingData);
        },
        (r) {
          expect(r, isNotNull);
          debugPrint('body => ${r.body}');
        },
      );
    });
  });
}
