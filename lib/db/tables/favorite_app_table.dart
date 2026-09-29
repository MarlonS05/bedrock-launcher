/// Schema for persisted favorite apps.
abstract final class FavoriteAppTable {
  static const name = 'favorite_apps';

  static const columnId = 'id';
  static const columnPackageName = 'package_name';
  static const columnDisplayOrder = 'display_order';

  /// Used in Migration 1
  static const create = '''
CREATE TABLE $name (
  $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
  $columnPackageName TEXT NOT NULL UNIQUE,
  $columnDisplayOrder INTEGER NOT NULL
)
''';

  /// Used in Migration 1
  static const createDisplayOrderIndex = '''
CREATE INDEX idx_${name}_display_order
ON $name ($columnDisplayOrder)
''';
}
