// Copyright 2021
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../src/cubit/location_cubit.dart';
import '../../src/location/geolocator_wrapper.dart';
import '../../src/persisted_data/hive_persisted_data.dart';

/// per https://pub.dev/packages/flutter_modular
/// this class is a Module that wraps the use of Location Service and Persisted data from that service.
/// Adding this module to a project/app provides access to location services, and the ability to persist
/// the results in on-device storage (via Hive: https://pub.dev/packages/hive and HiveFlutter https://pub.dev/packages/hive_flutter)
class LocationModule extends Module {
  final Widget locationWidget;
  LocationModule({required this.locationWidget});

  @override
  List<Bind> get binds => [
        Bind.lazySingleton((i) => HivePersistedData()),
        Bind.lazySingleton((i) => GeolocatorWrapper(persistedData: i.get<HivePersistedData>())),
        Bind.lazySingleton((i) => LocationCubit(locationService: i.get<GeolocatorWrapper>())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(Modular.initialRoute, child: (_, __) => locationWidget),
      ];
}
