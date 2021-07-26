import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'email_state.dart';

class EmailCubit extends Cubit<EmailState> {
  final String _regexSource = r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?";

  EmailCubit() : super(EmailInitial());

  void isValid(String value) {
    try {
      final regexp = RegExp(_regexSource);
      final result = regexp.hasMatch(value);
      emit(HasValidEmail(result));
    } catch (e) {
      // Invalid regex
      assert(false, e.toString());
    }
  }
}
