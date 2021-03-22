import 'package:enum_to_string/enum_to_string.dart';

import '../xfer.dart';
import 'xfer_failure.dart';

extension XferProtocolExtension on XferProtocol {
  String get toText => EnumToString.convertToString(this).toLowerCase();

  static XferProtocol protocol(String onUrl) {
    List<String> elements = onUrl.split('://');
    if (elements.length < 2) throw XferFailure(XferException.urlMissingProtocol);
    for (XferProtocol value in XferProtocol.values) {
      if (value.toText == elements[0].toLowerCase()) return value;
    }
    throw XferFailure(XferException.urlUnknownProtocol);
  }
}
