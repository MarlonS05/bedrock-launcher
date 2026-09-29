/// Schema for persisted preferred-apps preferences (single row).
abstract final class PreferredAppsPreferencesTable {
  static const name = 'preferred_apps_preferences';

  static const columnId = 'id';
  static const columnClockPackage = 'clock_package';
  static const columnPhonePackage = 'phone_package';
  static const columnCameraPackage = 'camera_package';
  static const columnGalleryPackage = 'gallery_package';

  /// Used in Migration 5
  static const create = '''
CREATE TABLE $name (
  $columnId INTEGER PRIMARY KEY CHECK ($columnId = 1),
  $columnClockPackage TEXT,
  $columnPhonePackage TEXT,
  $columnCameraPackage TEXT,
  $columnGalleryPackage TEXT
)
''';
}
