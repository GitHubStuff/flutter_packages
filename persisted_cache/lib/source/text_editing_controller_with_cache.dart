import 'package:flutter/material.dart';
import 'package:persisted_cache/persisted_cache.dart';

class TextEditingControllerWithCache extends TextEditingController {
  late final PersistedCache _persistedCache;

  TextEditingControllerWithCache({String? text, int limit = 10, required String cacheId})
      : assert(limit > 1),
        assert(cacheId.isNotEmpty),
        super(text: text) {
    _persistedCache = PersistedCache<String>(value: text, limit: limit, cacheId: cacheId);
  }

  String get text {
    _persistedCache.value = text;
    return super.text;
  }

  set text(String newValue) => 
}
