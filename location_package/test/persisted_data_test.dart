import 'package:location_package/src/app_exceptions.dart';
import 'package:location_package/src/location/location_data.dart';
import 'package:location_package/src/persisted_data/hive_persisted_data.dart';
import 'package:location_package/src/persisted_data/mock_persisted_data.dart';
import 'package:test/test.dart';

void main() {
  test('testing mock of persisted data', () async {
    MockPersistedData mockPersistedData = MockPersistedData();
    bool result = await mockPersistedData.setup();
    expect(result, true);
  });

  test('Returns null on unknown key', () async {
    MockPersistedData mockPersistedData = MockPersistedData();
    bool result = await mockPersistedData.setup();
    expect(result, true);
    LocationData? value = mockPersistedData.getLocationData();
    expect(value, null);
  });

  test('Returns value stored with correct type', () async {
    MockPersistedData mockPersistedData = MockPersistedData();
    bool result = await mockPersistedData.setup();
    expect(result, true);
    final LocationData data = LocationData(latitude: 100.0, longitude: -50.0, dateTimestamp: DateTime.now());
    mockPersistedData.setLocationData(data);
    LocationData? value = mockPersistedData.getLocationData();
    print('VALUE:${value?.toString()}');
    expect(value, data);
  });

  test('Live data test', () async {
    HivePersistedData persistedData = HivePersistedData();
    bool result = await persistedData.setup();
    expect(result, false);
  });

  test('PersistedStorageNotSetup setup not called throws exception on setValue', () async {
    MockPersistedData mockPersistedData = MockPersistedData();
    final LocationData data = LocationData(latitude: 100.0, longitude: -50.0, dateTimestamp: DateTime.now());
    expect(
      () => mockPersistedData.setLocationData(data),
      throwsA(isA<PersistedStorageNotSetup>()),
    );
  });

  test('PersistedStorageNotSetup setup not called throws exception on getValue', () async {
    MockPersistedData mockPersistedData = MockPersistedData();
    expect(
      () => mockPersistedData.getLocationData(),
      throwsA(isA<PersistedStorageNotSetup>()),
    );
  });
}
