// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_modular/flutter_modular.dart';
import 'package:http/http.dart' as http;

import 'xfer.dart';

class XferModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => Xfer(httpPostFuture: http.post, httpGetFuture: http.get)),
      ];

  @override
  List<ModularRouter> get routers => [];

  static Inject get to => Inject<XferModule>.of();
}
