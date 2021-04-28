import '../../src/location/location_data.dart';

bool persistedDataSetupComplete = false;

abstract class PersistedData {
  Future<bool> setup();
  LocationData? getLocationData();
  void setLocationData(LocationData value);
}
