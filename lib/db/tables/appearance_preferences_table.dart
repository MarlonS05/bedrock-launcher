/// Schema for persisted launcher appearance preferences (single row).
abstract final class AppearancePreferencesTable {
  static const name = 'appearance_preferences';

  static const columnId = 'id';
  static const columnThemeColor = 'theme_color';
  static const columnTextColor = 'text_color';
  static const columnShowTileSeparators = 'show_tile_separators';
  static const columnAppFont = 'app_font';

  /// Used in Migration 2
  static const create = '''
CREATE TABLE $name (
  $columnId INTEGER PRIMARY KEY CHECK ($columnId = 1),
  $columnThemeColor INTEGER NOT NULL,
  $columnTextColor TEXT NOT NULL CHECK ($columnTextColor IN ('black', 'white'))
)
''';
}
