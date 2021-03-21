// Copyright 2021 LTMM. All rights reserved.
// Uses of this source code is governed by 'The Unlicense' that can be
// found in the LICENSE file.

/// This is the template for [Localization], is does [not] need to be modified,
/// TODO: It requires:
/// [languages] folder, where there is an simple [.json] file with key/value pairs
/// of a [key: language text], the helper function [localize(context, key)] is used
/// to retrieve the correct lanuguage string. The name of a [language file] is the two(2) letter [locale]
/// name: the [template] has examples for English[en] and Spanish[es].
///
/// NOTE:
/// For [production] - [key without translation] text just returs the [key] so the app doesn't crash
/// For [development] - [key without translation] text throw an [assert] so the language file can be updated
import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart' as Foundation;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tracers_package/tracers.dart';

/// helper method to localize strings inline
String localize(BuildContext context, String key) {
  if (key == '') return key;
  if (Foundation.kReleaseMode) {
    /// In [kRelease] return the key if there isn't a translation to prevent [crash]
    return Localization.of(context)?.translate(key) ?? key;
  }

  /// For development any string [without translation] throws an [assert]
  final result = Localization.of(context)?.translate(key);
  if (result != null) return result;
  Log.E('No translations for "$key"');
  assert(result != null, 'No translations for "$key"');
  return key;
}

class Localization {
  final Locale locale;

  Localization(this.locale);

  // Helper method to keep the code in the widgets concise
  // Localizations are accessed using an InheritedWidget "of" syntax
  static Localization of(BuildContext context) => Localizations.of<Localization>(context, Localization);

  /// Static member to have a simple access to the delegate by the [MaterialApp](material_app_widget.dart)
  static const LocalizationsDelegate<Localization> delegate = _LocalizationsDelegate();

  Map<String, String> _localizedStrings;

  Future<bool> load() async {
    try {
      // Load the language JSON file from the "lang" folder
      String jsonString = await rootBundle.loadString('languages/${locale.languageCode}.json');
      Map<String, dynamic> jsonMap = json.decode(jsonString);

      _localizedStrings = jsonMap.map((key, value) {
        return MapEntry(key, value.toString());
      });

      return true;
    } catch (error) {
      return false;
    }
  }

  // This method will be called from every widget which needs a localized text
  String translate(String key) {
    return _localizedStrings[key];
  }
}

// LocalizationsDelegate is a factory for a set of localized resources
// In this case, the localized strings will be gotten in an AppLocalizations object
class _LocalizationsDelegate extends LocalizationsDelegate<Localization> {
  // This delegate instance will never change (it doesn't even have fields!)
  // It can provide a constant constructor.
  const _LocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    // Include all of your supported language codes here
    return ['en', 'es'].contains(locale.languageCode);
  }

  @override
  Future<Localization> load(Locale locale) async {
    // AppLocalizations class is where the JSON loading actually runs
    Localization localizations = new Localization(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(_LocalizationsDelegate old) => false;
}
