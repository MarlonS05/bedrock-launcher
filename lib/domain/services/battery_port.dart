abstract interface class BatteryPort {
  /// Returns the current battery charge level as an integer from 0 to 100.
  Future<int> getBatteryLevel();
}
