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

class LanguageDto {
  final Map<String, Map<String, String>> catalog;
  String _language = 'en';

  LanguageDto(this.catalog);

  set language(String newLanguage) {
    assert(catalog.containsKey(newLanguage), 'Locale: <$newLanguage> is not in catalog');
    _language = newLanguage;
  }

  String word(String key) {
    assert(catalog.containsKey(_language), 'Locale: <$_language> is not in catalog');
    Map<String, String> wordList = catalog[_language]!;
    assert(wordList[key] != null, 'No lookup for [$key]');
    return wordList[key] ?? key;
  }
}