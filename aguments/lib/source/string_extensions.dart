extension DateTimeExtension on String {
  DateTime get sqlite => DateTime.parse(this);
}
