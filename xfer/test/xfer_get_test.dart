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

  group('xfer.get("https://"', () {
    test('"http://" get - no path', () async {
      final Either<XferFailure, XferResponse> result = await xfer.get('http://');
      result.fold(
        (err) {
          expect(err, isNotNull);
          expect(err.xferException, XferException.invalidXferRequest);
        },
        (r) => null,
      );
    });
  });

  group('xfer.get("asset://path/assetFile.ext, headers: Map<String,String> headers"', () {
    test('Test "asset://" with no path', () async {
      final Either<XferFailure, XferResponse> result = await xfer.get('asset://');
      result.fold(
        (err) {
          expect(err, isNotNull);
          expect(err.xferException, XferException.headerUnknownContentType);
        },
        (r) => expect(r, isNull),
      );
    });

    test('Test "asset://nosuchpath" with invalid path', () async {
      final Either<XferFailure, XferResponse> result = await xfer.get(
        'asset://nosuchpath',
        headers: {'Content-Type': 'application/json'},
      );
      result.fold(
        (err) {
          debugPrint(err.toString());
          expect(err, isNotNull);
          expect(err.xferException, XferException.assetReadError);
        },
        (r) => null,
      );
    });
    test('Test "asset://onboarding/en_services.json" get with valid item', () async {
      final Either<XferFailure, XferResponse> result = await xfer.get(
        'asset://onboarding/en_services.json',
        headers: {'Content-Type': 'application/json'},
      );
      result.fold(
        (err) {
          expect(err, isNull);
        },
        (r) {
          expect(r, isNotNull);
          expect(r.statusCode, 200);
          debugPrint('body => ${r.body}');
        },
      );
    });
  });
}
