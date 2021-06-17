import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../xfer.dart';
import 'xfer_content_type.dart';

Future<Either<XferFailure, XferResponse>> assetGet(String url, {Map<String, String>? headers}) async {
  if (headers == null || headers.isEmpty) return Left(XferFailure(XferException.headerUnknownContentType));

  final String path = url.split('://').last;
  if (path.isEmpty) return Left(XferFailure(XferException.assetArguementError, code: 'Missing path'));
  return headers.contentType().fold(
    (err) {
      return Left(err);
    },
    (contentType) async {
      switch (contentType) {
        case XferContentType.applicationJson:
        case XferContentType.textHTML:
        case XferContentType.textPlain:
          try {
            final contents = await rootBundle.loadString(path);
            return Right(XferResponse(contents, 200, protocol: XferProtocol.asset));
          } catch (error) {
            return Left(XferFailure(XferException.assetReadError));
          }
        case XferContentType.image:
          try {
            final assetImage = AssetImage(path);
            return Right(XferResponse(assetImage, 200, protocol: XferProtocol.asset));
          } catch (error) {
            return Left(XferFailure(XferException.assetReadError));
          }
      }
    },
  );
}
