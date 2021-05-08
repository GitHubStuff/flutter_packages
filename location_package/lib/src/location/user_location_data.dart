// Copyright 2021, LTMM

/// Abstract class app must implements when dealing with location data
abstract class UserLocationData {
  double latitude;
  double longitude;
  DateTime dateTimestamp;
  UserLocationData({required this.latitude, required this.longitude, required this.dateTimestamp});
}
