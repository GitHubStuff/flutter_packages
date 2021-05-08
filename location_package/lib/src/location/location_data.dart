import 'package:hive/hive.dart';

part 'location_data.g.dart';

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
  String toString() => 'LAT:$latitude\nLONG:$longitude\nTIME:${dateTimestamp.toIso8601String()}';
}
