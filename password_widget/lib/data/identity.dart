import 'package:flutter_extras/source/date_time_extensions.dart';

import '../constants.dart' as K;

class Identity {
  String _email = '';
  String _password = '';
  String _dateTime = '';
  final K.WidgetType widgetType;
  Identity({required this.widgetType, String email = '', String password = ''}) {
    _email = email.toLowerCase();
    _password = password;
    _dateTime = DateTimeExtension.asSqlite();
  }

  String get email => _email;
  String get password => _password;
  String get dateTime => _dateTime;
}
