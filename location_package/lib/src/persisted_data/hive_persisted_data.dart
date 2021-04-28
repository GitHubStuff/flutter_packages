import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:location_package/src/location/location_data.dart';
import 'package:location_package/src/persisted_data/persisted_data.dart';

import '../app_exceptions.dart';
import '../constants.dart' as K;

class HivePersistedData implements PersistedData {
  static late Box _box;

  @override
  Future<bool> setup() async {
    try {
      await Hive.initFlutter();
      _box = await Hive.openBox(K.hiveBoxName);
      persistedDataSetupComplete = true;
      return true;
    } on NullThrownError {} on MissingPluginException {} catch (e) {
      throw UnknownHiveException(e.toString());
    }
    return false;
  }

  @override
  LocationData? getLocationData() {
    // TODO: implement getLocationData
    throw UnimplementedError();
  }

  @override
  void setLocationData(LocationData value) {
    // TODO: implement setLocationData
  }
}
