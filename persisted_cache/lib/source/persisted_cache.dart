// Copyright 2021, LTMM LLC.
// Enables the use of storing a selection of <T> items in system prefs, that can be recalled for use later.
// NOTE: Items are cached ONLY after they are read for the first time (eg: var x = persistedCache.value).
// If a cached value is not appearing in the list, could be because it wasn't read.
// This is to allow the value to be edit/changed before being committed to the cache.
import 'dart:collection';
import 'dart:convert';

import 'package:flutter_extras/flutter_extras.dart';
import 'package:xfer/xfer.dart';

typedef void CallBack<T>(T value);

class PersistedCache<T> {
  /// Special suffix to insure a unique key in prefs
  final String _suffix = '22c8c0e406454373b2ba46f83f0b65ee';

  /// Composed URL to preference
  late String _lookupKey;

  /// The number of items to keep in cache
  int _limit;

  /// Should be a unique string that is added to the _suffix to create a unique key for pref
  String _cacheId;

  /// Initial value to place in the cache
  T? _value;

  /// List of cached items
  LinkedHashMap<String, T> _cacheMap = LinkedHashMap();
  PersistedCache({
    T? value,
    int limit = 10,
    required String cacheId,
  })  : _value = value,
        _limit = limit,
        _cacheId = cacheId,
        assert(limit > 1),
        assert(cacheId.isNotEmpty) {
    _lookupKey = 'pref://$_cacheId$_suffix';
    _load();
  }

  /// When a value is read, that pushes it into the cache
  T? get value {
    addItem(_value);
    return _value;
  }

  set value(T? newValue) => _value = newValue;

  /// Returns a list of the cached value
  List<T> cachedItems() {
    final List<T> result = [];
    _cacheMap.forEach((key, value) => result.add(value));
    return result;
  }

  bool get isEmpty => _cacheMap.isEmpty;

  /// Adds an item to the cache list, along with a time stamp to keep the most recent at the top of the
  /// list, and trims the list if it goes over 'limit'
  Future addItem(T? item) async {
    if (item == null || (item is String && item.isEmpty)) return;
    _checkType(item);
    _cacheMap.removeWhere((key, value) => value == item);
    _cacheMap[DateTimeExtension.unique().toIso8601String()] = item;
    if (_cacheMap.length == 1) return;

    _cacheMap = LinkedHashMap.fromEntries(_cacheMap.entries.toList()..sort((e1, e2) => e2.key.compareTo(e1.key)));

    /// Sort keys(aka timestamp) from most-to-least recent
    List<String> keyList = _cacheMap.keys.toList(growable: true)..sort((k1, k2) => k2.compareTo(k1)); //k2 compareTo k1

    /// remove the oldest when length exceeds limit
    while (keyList.length > _limit) {
      _cacheMap.remove(keyList.last);
      keyList.removeLast();
    }
    _cacheMap = LinkedHashMap.fromIterable(keyList, key: (k) => k, value: (k) => _cacheMap[k]!);
    await _save();
  }

  /// Data type checker to insure only primative types are saved
  void _checkType(Object object) {
    if (object is bool) return;
    if (object is double) return;
    if (object is int) return;
    if (object is String) return;
    assert(false, 'object: ${object.toString()} is not bool, double, int, or string');
  }

  /// Converts the cached items to a string and store is prefs
  /// This should be so fast that the await will not stutter/slow updates
  Future _save() async {
    final String data = json.encode(_cacheMap);
    await Xfer().put(_lookupKey, value: data);
  }

  /// Reads the cached items from the pref a string that is converted to the List<T>
  Future _load() async {
    Xfer().get(_lookupKey, value: '').then((result) {
      result.fold((err) {
        assert(false, 'Could not read $_lookupKey : ${err.toString()}');
      }, (data) {
        String response = data.body as String;
        if (response.isNotEmpty) {
          Map<String, dynamic> map = json.decode(response);
          map.forEach((key, value) {
            _cacheMap[key] = value as T;
          });
        }
      });
    });
  }
}
