import 'package:hive/hive.dart';

import 'user_location_data.dart';

part 'location_data.g.dart';


@HiveType(typeId: 0)
class LocationData extends HiveObject implements UserLocationData {
  @HiveField(0)
  late final double latitude;
  @HiveField(1)
  late final double longitude;
  @HiveField(2)
  late final DateTime dateTimestamp;

  LocationData({required this.latitude, required this.longitude, required this.dateTimestamp});

  @override
  String toString() => 'LAT:$latitude\nLONG:$longitude\nTIME:${dateTimestamp.toIso8601String()}';
}
