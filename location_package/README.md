# location_package

This package provides a BLoC design to get the user's location and providing information needed
to use location services to find near-by locations

## Getting Started

### Persisted Data

This element is to store location information on-device to use in comparing distance between current and save-location. The idea being that queries to back-end services can be reduced and that information on-boarded so that subsequent queries can use on-device data if the distance between the save position and current position is within a threshold (say 200 meters)

#### class LocationData

```dart
@HiveType(typeId: 0)
class LocationData extends HiveObject {
  @HiveField(0)
  final double latitude;
  @HiveField(1)
  final double longitude;
  @HiveField(2)
  final DateTime dateTimestamp;

  LocationData({required this.latitude, required this.longitude, required this.dateTimestamp});

  @override
  String toString() => 'LAT:$latitude LONG:$longitude TIME:${dateTimestamp.toIso8601String()}';
}
```

This class uses Hive package to persist and object that is a location, it has latitude, longitude, and timestamp.

#### class MockPersistedData

```dart
import '../../src/location/location_data.dart';
import '../app_exceptions.dart';
import 'persisted_data.dart';

class MockPersistedData implements PersistedData {
  static Map<String, LocationData> _data = Map();

  // Must be called to simulate set-up likes those for hive & get_location packages
  Future<bool> setup() async {
    persistedDataSetupComplete = true;
    return true;
  }

  // This method is exclusive to mock 
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

```

This is used to Mock persisting the data for unit tests. The data saved/read is ***LocationData***

#### class HivePeristedData

```dart
class HivePersistedData implements PersistedData {
  static late Box _box;

  @override
  Future<bool> setup() async {
    try {
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
    final locationData = _box.get(usingKey) as LocationData;
    return locationData;
  }

  @override
  void setLocationData(LocationData value, {required String usingKey}) {
    _box.put(usingKey, value);
  }
}
```

Implementation using Hive for the backend-store

#### class MockLocation

```dart
class MockLocation extends LocationService {
  LocationData? locationData;
  LocationServiceStatus locationServiceStatus;

  MockLocation({required PersistedData persistedData, this.locationData, required this.locationServiceStatus}) : super(persistedData: persistedData);

  @override
  Future<LocationData?> getCurrentLocation() async => locationData;

  @override
  Future<LocationServiceStatus> getStatus() async => locationServiceStatus;
}
```

Allows Mocking of a location, with the use a PersistedData class (like MockPersistedData or HivePersistedData)

#### class GeolocationWrapper

```dart
class GeolocatorWrapper extends LocationService {
  GeolocatorWrapper({required PersistedData persistedData}) : super(persistedData: persistedData);

  @override
  Future<LocationData?> getCurrentLocation() async {
    LocationServiceStatus status = await getStatus();
    if (status != LocationServiceStatus.enabled) return null;
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.bestForNavigation);
    LocationData result = LocationData(
      latitude: position.latitude,
      longitude: position.longitude,
      dateTimestamp: position.timestamp ?? DateTime.now(),
    );
    return result;
  }

  @override
  Future<LocationServiceStatus> getStatus() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) return LocationServiceStatus.disabled;
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return LocationServiceStatus.denied;
        }
      }
      if (permission == LocationPermission.deniedForever) {
        return LocationServiceStatus.deniedForever;
      }
      return LocationServiceStatus.enabled;
    } on PermissionDefinitionsNotFoundException {
      throw MissingLocationPermission();
    }
  }
}
```

Implementation of LocationServices that uses Geolocator package to the user/device latitude and longitude

## Conclusion

### Be kind to each other
