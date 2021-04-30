import '../../src/location/location_data.dart';

// Global value that can be used to indicate  'Future<bool>setup()' was called.
bool persistedDataSetupComplete = false;

abstract class PersistedData {
  Future<bool> setup();
  LocationData? getLocationData({required String usingKey});
  void setLocationData(LocationData value, {required String usingKey});
}
