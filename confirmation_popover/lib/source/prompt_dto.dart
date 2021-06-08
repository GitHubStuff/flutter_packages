// Copyright 2021, LTMM, LLC.
import 'package:flutter_extras/flutter_extras.dart';

/// Helper class to ensure all the key/values are included
class PromptDto extends LanguageDto {
  final String _confirmChange = 'confirmChange';
  final String _caption = 'caption';
  final String _confirm = 'confirm';
  final String _cancel = 'cancel';

  PromptDto(WordList wordList) : super(wordList) {
    wordList.forEach((key, value) {
      assert(value[_confirmChange] != null, 'Missing $_confirmChange');
      assert(value[_caption] != null, 'Missing $_caption');
      assert(value[_confirm] != null, 'Missing $_confirm');
      assert(value[_cancel] != null, 'Missing $_cancel');
    });
  }
}
