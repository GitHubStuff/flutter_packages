// Copyright 2021, LTMM
import '../../src/location/location_data.dart';
import '../app_exceptions.dart';
import 'persisted_data.dart';

/// Mock of PersistedData abstract class to use for testing/development
class MockPersistedData implements PersistedData {
  static Map<String, LocationData> _data = Map();

  Future<bool> setup() async {
    persistedDataSetupComplete = true;
    return true;
  }

  void overridePersistedData(bool newValue) => persistedDataSetupComplete = newValue;

  LocationData? getLocationData({required String usingKey}) {
    if (!persistedDataSetupComplete) throw PersistedStorageNotSetup();
    return (_data.isEmpty) ? null : _data[usingKey];
  }

  void setLocationData(LocationData value, {required String usingKey}) {
    if (!persistedDataSetupComplete) throw PersistedStorageNotSetup();
    _data[usingKey] = value;
  }
}
