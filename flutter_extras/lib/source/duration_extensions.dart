extension DurationExtension on Duration {
  Duration add(Duration amount) => Duration(microseconds: this.inMicroseconds + amount.inMicroseconds);
  Duration sub(Duration amount) => Duration(microseconds: this.inMicroseconds - amount.inMicroseconds);
}
