import '../../src/location/location_data.dart';

bool persistedDataSetupComplete = false;

abstract class PersistedData {
  Future<bool> setup();
  LocationData? getLocationData({required String usingKey});
  void setLocationData(LocationData value, {required String usingKey});
}
