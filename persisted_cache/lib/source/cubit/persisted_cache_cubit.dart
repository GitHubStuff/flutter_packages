import 'dart:collection';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:xfer/xfer.dart';

part 'persisted_cache_state.dart';

class PersistedCacheCubit extends Cubit<PersistedCacheState> {
  PersistedCacheCubit() : super(PersistedCacheInitial());

  Future save<T>(LinkedHashMap<String, dynamic> cache, String key) async {
    debugPrint('${DateTime.now().toIso8601String()}🟥 Starting SAVE');
    final String data = json.encode(cache);
    Xfer().put(key, value: data).then((value) {
      debugPrint('${DateTime.now().toIso8601String()}⏱ Finished SAVE');
    });
  }
}
