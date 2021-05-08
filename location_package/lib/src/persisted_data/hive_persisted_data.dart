// Copyright 2021
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:location_package/src/location/location_data.dart';
import 'package:location_package/src/location/user_location_data.dart';
import 'package:location_package/src/persisted_data/persisted_data.dart';

import '../app_exceptions.dart';
import '../private_constants.dart' as K;

/// An implementation of 'PersistedData'-abstract class that uses Hive to persist location data
class HivePersistedData implements PersistedData {
  static late Box _box;

  @override
  Future<bool> setup() async {
    try {
      if (persistedDataSetupComplete) return true;
      await Hive.initFlutter();
      Hive.registerAdapter(LocationDataAdapter());
      _box = await Hive.openBox(K.hiveBoxName);
      persistedDataSetupComplete = true;
      return true;
    } on NullThrownError {} on MissingPluginException {} catch (e) {
      throw UnknownHiveException(e.toString());
    }
    return false;
  }

  @override
  LocationData? getLocationData({required String usingKey}) {
    if (!persistedDataSetupComplete) throw PersistedStorageNotSetup();
    final locationData = _box.get(usingKey) as LocationData;
    return locationData;
  }

  @override
  void setLocationData(UserLocationData value, {required String usingKey}) {
    if (!persistedDataSetupComplete) throw PersistedStorageNotSetup();
    _box.put(usingKey, value);
  }
}
