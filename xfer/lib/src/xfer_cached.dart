import 'package:dartz/dartz.dart';
import 'package:xfer/src/cached_header.dart';

import '../xfer.dart';

Future<Either<XferFailure, XferResponse>> cachedGet(String url, {Map<String, String>? headers}) async {
  if (headers == null) return Left(XferFailure(XferException.headersMissing, code: 'Missing headers'));
  final CachedHeader? cachedHeader = CachedHeader.fromHeader(headers);
  if (cachedHeader == null) return Left(XferFailure(XferException.headersMissingRequiredValues, code: 'Missing required fields'));
  final widget = cachedHeader.cachedNetworkImage(url: url);
  return Right(XferResponse(widget, 200, protocol: XferProtocol.cachedImage));
}
