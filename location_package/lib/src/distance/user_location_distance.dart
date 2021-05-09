class UserLocationDistance {
  final double distanceInMeters;
  final Duration interval;
  UserLocationDistance({required this.distanceInMeters, required this.interval});
  @override
  String toString() => '{distance:$distanceInMeters,\ninterval:${interval.inSeconds}/seconds}';
}
