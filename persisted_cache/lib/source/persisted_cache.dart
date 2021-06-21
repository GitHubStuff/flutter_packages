import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_extras/flutter_extras.dart';
import 'package:xfer/xfer.dart';

typedef void CallBack<T>(T value);

class PersistedCache<T> {
  final String _suffix = '22c8c0e406454373b2ba46f83f0b65ee';
  late String _lookupKey;
  int _limit;
  String _cacheId;
  T? _value;
  LinkedHashMap<String, T> _cacheMap = LinkedHashMap();

  PersistedCache({T? value, int limit = 10, required String cacheId})
      : _value = value,
        _limit = limit,
        _cacheId = cacheId,
        assert(limit > 1),
        assert(cacheId.isNotEmpty) {
    _lookupKey = 'pref://$_cacheId$_suffix';
    _load();
  }

  T? get value {
    addItem(_value);
    return _value;
  }

  set value(T? newValue) => _value = newValue;

  List<T> cachedItems() {
    final List<T> result = [];
    _cacheMap.forEach((key, value) => result.add(value));
    return result;
  }

  Future addItem(T? item) async {
    debugPrint('addItem $item');
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

  void _checkType(Object object) {
    if (object is bool) return;
    if (object is double) return;
    if (object is int) return;
    if (object is String) return;
    assert(false, 'object: ${object.toString()} is not bool, double, int, or string');
  }

  Future _save() async {
    debugPrint('${DateTime.now().toIso8601String()}🟥 Starting SAVE');
    final String data = json.encode(_cacheMap);
    Xfer().put(_lookupKey, value: data).then((value) {
      debugPrint('${DateTime.now().toIso8601String()}⏱ Finished SAVE');
    });
  }

  Future _load() async {
    debugPrint('🥸 Starting Load');
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
          debugPrint('${map.toString()}');
        }
      });
      debugPrint('🟣 Finished Load ${cachedItems()}');
    });
  }
}
