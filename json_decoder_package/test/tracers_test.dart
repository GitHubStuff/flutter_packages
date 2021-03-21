import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:json_decoder/jsode_decoder.dart';

//import 'package:tracers/tracers.dart';

void main() {
  test('tests decode of good and bad json list', () {
    final String good = '[{"name":"steven","title":"grand poobah"},{"name":"steven","title":"grand poobah"}]';
    final Either<Exception, JsonDecoded> goodResult = JSONDecoder.decode(good);
    goodResult.fold(
      (l) => null,
      (r) => expect(r.jsonType, JsonDecodeType.list),
    );

    final String bad = '[{"name":"steven","title":"grand poobah"},{"name":"steven","title":"grand poobah"},X]';
    final Either<Exception, JsonDecoded> badResult = JSONDecoder.decode(bad);
    badResult.fold(
      (l) => l is FileSystemException ? expect(1, 1) : expect(1, 2),
      (r) => expect(r.jsonType, JsonDecodeType.map),
    );
  });
}
