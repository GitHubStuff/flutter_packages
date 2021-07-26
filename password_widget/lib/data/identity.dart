import '../constants.dart' as K;

class Identity {
  String _email = '';
  String _password = '';
  final K.WidgetType widgetType;
  Identity({required this.widgetType, String email = '', String password = ''}) {
    _email = email.toLowerCase();
    _password = password;
  }

  String get email => _email;
  String get password => _password;
}
