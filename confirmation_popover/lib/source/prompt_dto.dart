// Copyright 2021, LTMM, LLC.
import 'package:flutter_extras/flutter_extras.dart';

/// Helper class to ensure all the key/values are included
class PromptDto extends LanguageDto {
  static final String confirmChange = 'confirmChange';
  static final String caption = 'caption';
  static final String confirm = 'confirm';
  static final String cancel = 'cancel';
  static final String thirdOption = 'thirdOption';

  PromptDto(WordList wordList) : super(wordList, keys: [confirmChange, caption, confirm, cancel]);

  factory PromptDto.threeButtons(WordList wordList) {
    LanguageDto(wordList, keys: [confirmChange, caption, confirm, cancel, thirdOption]);
    PromptDto result = PromptDto(wordList);
    return result;
  }
}
