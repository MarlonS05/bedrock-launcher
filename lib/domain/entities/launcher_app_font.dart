/// Font option for launcher app name labels.
class LauncherAppFont {
  const LauncherAppFont(this.familyId);

  /// Device family id, or [system] for the platform default.
  final String familyId;

  static const system = LauncherAppFont('system');

  bool get isSystem => familyId == 'system';

  String get label => isSystem ? 'Default' : familyId;

  static LauncherAppFont fromStorage(String value) {
    if (value.isEmpty || value == 'system') {
      return system;
    }
    return LauncherAppFont(value);
  }

  String toStorage() => familyId;

  @override
  bool operator ==(Object other) {
    return other is LauncherAppFont && other.familyId == familyId;
  }

  @override
  int get hashCode => familyId.hashCode;
}
