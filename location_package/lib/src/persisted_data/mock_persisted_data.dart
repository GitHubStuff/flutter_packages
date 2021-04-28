import '../../src/location/location_data.dart';
import '../app_exceptions.dart';
import '../constants.dart' as K;
import 'persisted_data.dart';

class MockPersistedData implements PersistedData {
  static Map<String, LocationData> _data = Map();

  Future<bool> setup() async {
    persistedDataSetupComplete = true;
    return true;
  }

  void overridePersistedData(bool newValue) => persistedDataSetupComplete = newValue;

  LocationData? getLocationData() {
    if (!persistedDataSetupComplete) throw PersistedStorageNotSetup();
    return (_data.isEmpty) ? null : _data[K.locationStorageKey];
  }

  void setLocationData(LocationData value) => (persistedDataSetupComplete) ? _data[K.locationStorageKey] = value : throw PersistedStorageNotSetup();
}
