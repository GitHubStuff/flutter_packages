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

  group('xfer.post("asset://path/assetFile.ext"', () {
    test('Test "asset://" post with not content', () async {
      final Either<XferFailure, XferResponse> result = await xfer.post('asset://');
      result.fold(
        (err) {
          expect(err, isNotNull);
          expect(err.xferException, XferException.headerUnknownContentType);
        },
        (r) => expect(r, isNull),
      );
    });
    test('Test "asset://nosuchpath" post with invalid asset path', () async {
      final Either<XferFailure, XferResponse> result = await xfer.post(
        'asset://nosuchpath',
        headers: {'Content-Type': 'application/json'},
      );
      result.fold(
        (err) {
          debugPrint(err.toString());
          expect(err, isNotNull);
          expect(err.xferException, XferException.assetReadError);
        },
        (r) => expect(r, isNull),
      );
    });
    test('"asset://onboarding/en_services.json" post - success 201', () async {
      final Either<XferFailure, XferResponse> result = await xfer.post(
        'asset://onboarding/en_services.json',
        headers: {'Content-Type': 'application/json'},
      );
      result.fold(
        (err) {
          expect(err, isNull);
        },
        (r) {
          expect(r, isNotNull);
          expect(r.statusCode, 201);
          debugPrint('body => ${r.body}');
        },
      );
    });
  });

  
}
