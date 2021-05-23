import 'package:dartz/dartz.dart';
import 'package:xfer/src/xfer_failure.dart';

import '../xfer.dart';

enum XferContentType {
  applicationJson,
  textHTML,
  textPlain,
  image,
}

extension XferContentTypeExtenstion on XferContentType {
  static Either<XferFailure, XferContentType> getType(String type) {
    switch (type.toLowerCase()) {
      case 'application/json':
        return Right(XferContentType.applicationJson);
      case 'text/html':
        return Right(XferContentType.textHTML);
      case 'text/plain':
        return Right(XferContentType.textPlain);
      case 'image/gif':
      case 'image/jpeg':
      case 'image/jpg':
      case 'image/png':
        return Right(XferContentType.image);
      default:
        return Left(XferFailure(XferException.headerUnknownContentType, code: 'Unsupported Type => $type'));
    }
  }
}

extension XferContentTypeExtenstions on Map<String, String> {
  Either<XferFailure, XferContentType> contentType() {
    for (var key in this.keys) {
      if (key.toLowerCase() == 'content-type') return XferContentTypeExtenstion.getType(this[key]!);
    }
    return Left(XferFailure(XferException.headerUnknownContentType));
  }
}
