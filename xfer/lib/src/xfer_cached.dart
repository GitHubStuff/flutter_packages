import 'package:dartz/dartz.dart';
import 'package:xfer/src/cached_header.dart';

import '../xfer.dart';
import 'xfer_protocol_extension.dart';

Either<XferFailure, XferResponse> cachedGet(String url, {Map<String, String>? headers, CachedImageError? cachedImageError}) {
  try {
    XferProtocol protocol = XferProtocolExtension.protocol(url);
    if (protocol != XferProtocol.cachedImage)
      return Left(
        XferFailure(XferException.invalidXferRequest, code: 'cachedImage only allowed protocol not: $protocol'),
      );
    if (headers == null) return Left(XferFailure(XferException.headersMissing, code: 'Missing headers'));
    final CachedHeader? cachedHeader = CachedHeader.fromHeader(headers);
    if (cachedHeader == null) return Left(XferFailure(XferException.headersMissingRequiredValues, code: 'Missing required fields'));
    try {
      final widget = cachedHeader.cachedNetworkImage(url: url, cachedImageError: cachedImageError);
      return Right(XferResponse(widget, 200, protocol: XferProtocol.cachedImage));
    } catch (err) {
      return Left(XferFailure(XferException.http400BadRequest, code: err.toString()));
    }
  } catch (error) {
    return Left(error as XferFailure);
  }
}
