// Copyright 2021, LTMM
import '../../src/location/location_data.dart';

// Global value that can be used to indicate  'Future<bool>setup()' was called.
bool persistedDataSetupComplete = false;

/// Abstract class apps follow when persisting LocationData
abstract class PersistedData {
  Future<bool> setup();
  LocationData? getLocationData({required String usingKey});
  void setLocationData(LocationData value, {required String usingKey});
}
