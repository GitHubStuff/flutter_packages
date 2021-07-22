import 'package:bloc/bloc.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

import '../source/constants.dart' as K;

part 'keypad_state.dart';

class KeypadCubit extends Cubit<KeypadState> {
  String keypadText = '0';
  int? _rightOfDecimal;
  double value = 0.0;
  late bool _allowDecimal;
  final K.KeypadTypes keypadType;
  int _decimalDigits = 0;

  KeypadCubit({this.keypadType = K.KeypadTypes.money}) : super(KeypadInitial()) {
    _allowDecimal = (keypadType != K.KeypadTypes.integer);
    _rightOfDecimal = _allowDecimal ? ((keypadType == K.KeypadTypes.money) ? 2 : 100) : null;
    Future.delayed(Duration(milliseconds: 300), () {
      _addItem('0');
    });
  }

  Future setButtonPressed() async {
    emit(KeypadValueSet(keypadText));
  }

  void reset() {
    keypadText = '0';
    value = 0.0;
    _decimalDigits = 0;
    emit(KeypadInitial());
    _addItem('0');
  }

  Future add(String item, K.ButtonContent content) async {
    if (content == K.ButtonContent.number) return _addNumber(item);
    if (content == K.ButtonContent.decimal) return _addDecimal();
    if (content == K.ButtonContent.delete) return _remove();
  }

  void _remove() {
    if (keypadText.length == 1) {
      keypadText = '0';
      _addItem('');
      return;
    }
    var newString = keypadText.substring(keypadText.length - 1);
    if (newString == K.decimalString) {
      _decimalDigits = 0;
    }
    keypadText = keypadText.substring(0, keypadText.length - 1);
    _addItem('');
  }

  void _addDecimal() {
    if (keypadType == K.KeypadTypes.integer) return;
    _decimalDigits = 1;
    _addItem(K.decimalString);
  }

  void _addNumber(String number) {
    if (_decimalDigits != 0) {
      if (_decimalDigits <= _rightOfDecimal!) {
        _decimalDigits++;
      } else {
        return;
      }
    }
    _addItem(number);
  }

  void _addItem(String item) {
    keypadText = (keypadText == '0') ? item : keypadText + item;
    final num? parsed = num.tryParse(keypadText);
    if (parsed == null) {
      keypadText = '0';
      emit(KeypadInitial());
      return;
    }

    if (keypadType == K.KeypadTypes.money) {
      final formatCurrency = NumberFormat.simpleCurrency().format(parsed);
      emit(KeypadValued(formatCurrency));
      return;
    }

    final txt = (num is int) ? NumberFormat('###,###,##0').format(num) : NumberFormat('###,###,##0.#').format(num);
    emit(KeypadValued(txt));
  }
}
