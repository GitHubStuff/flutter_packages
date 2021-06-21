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
  @override
  String get text {
    _persistedCache.value = super.text;
    //_persistedCache.addItem(super.text);
    //debugPrint('text:$text');
    return super.text;
  }

  @override
  set text(String newValue) {
    debugPrint('text:$text');
    super.text = text;
  }

  List<String> cachedItems() => _persistedCache.cachedItems() as List<String>;
}
