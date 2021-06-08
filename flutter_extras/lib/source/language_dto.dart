// Copyright 2021, LTMM LLC.

/// Allows for passing a collection of localized strings that are used within a widget for display text, button titles, etc.
/// The layout for calling is:
/*
LanguageDto _words = LanguageDto({
  'en': {
    'confirmChange': 'Confirm Change',
    'caption': 'Please confirm your choice',
    'confirm': 'Confirm',
    'cancel': 'Cancel',
  },
  'es': {
    'confirmChange': 'Confirmar cambio',
    'caption': 'Confirma tu elección',
    'confirm': 'confirmar',
    'cancel': 'cancelar',
  }
});
*/
/// The 'map-of-maps' has a localization code (eg: 'en' for english, 'es' for spanish), and then a key/value lookup.
/// By design asserts are thrown for any missing languages, or translations to catch issues in development, in
/// production it will just return the 'key' value used for lookups.

typedef WordList = Map<String, Map<String, String>>;
typedef LanguageTable = Map<String, String>;

class LanguageDto {
  final WordList catalog;
  List<String> keys;
  String _language = 'en';

  LanguageDto(this.catalog, {required this.keys}) {
    catalog.forEach((key, value) {
      LanguageTable language = catalog[key]!;
      for (String token in keys) {
        assert(language[token] != null, 'Missing translation for $token in language:$key');
      }
    });
  }

  set language(String newLanguage) {
    assert(catalog.containsKey(newLanguage), 'Locale: <$newLanguage> is not in catalog');
    _language = newLanguage;
  }

  String word(String key) {
    assert(catalog.containsKey(_language), 'Locale: <$_language> is not in catalog');
    LanguageTable wordList = catalog[_language]!;
    assert(wordList[key] != null, 'No lookup for [$key]');
    return wordList[key] ?? key;
  }
}
