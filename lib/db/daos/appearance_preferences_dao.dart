import 'package:bedrock_launcher/db/tables/appearance_preferences_table.dart';
import 'package:bedrock_launcher/domain/entities/appearance_preferences.dart';
import 'package:bedrock_launcher/domain/entities/launcher_app_font.dart';
import 'package:bedrock_launcher/domain/entities/launcher_text_color.dart';
import 'package:sqflite/sqflite.dart';

class AppearancePreferencesDao {
  AppearancePreferencesDao(this._db);

  final Database _db;

  Future<AppearancePreferences> get() async {
    final rows = await _db.query(
      AppearancePreferencesTable.name,
      where: '${AppearancePreferencesTable.columnId} = ?',
      whereArgs: [1],
      limit: 1,
    );

    if (rows.isEmpty) {
      return AppearancePreferences.defaults;
    }

    return _fromRow(rows.first);
  }

  Future<void> setThemeColor(int themeColorArgb) async {
    await _ensureRowExists();
    await _db.update(
      AppearancePreferencesTable.name,
      {AppearancePreferencesTable.columnThemeColor: themeColorArgb},
      where: '${AppearancePreferencesTable.columnId} = ?',
      whereArgs: [1],
    );
  }

  Future<void> setTextColor(LauncherTextColor textColor) async {
    await _ensureRowExists();
    await _db.update(
      AppearancePreferencesTable.name,
      {AppearancePreferencesTable.columnTextColor: textColor.toStorage()},
      where: '${AppearancePreferencesTable.columnId} = ?',
      whereArgs: [1],
    );
  }

  Future<void> save(AppearancePreferences preferences) async {
    await _ensureRowExists();
    await _db.update(
      AppearancePreferencesTable.name,
      {
        AppearancePreferencesTable.columnThemeColor: preferences.themeColorArgb,
        AppearancePreferencesTable.columnTextColor:
            preferences.textColor.toStorage(),
        AppearancePreferencesTable.columnShowTileSeparators:
            preferences.showTileSeparators ? 1 : 0,
        AppearancePreferencesTable.columnAppFont: preferences.appFont.toStorage(),
      },
      where: '${AppearancePreferencesTable.columnId} = ?',
      whereArgs: [1],
    );
  }

  Future<void> _ensureRowExists() async {
    final rows = await _db.query(
      AppearancePreferencesTable.name,
      where: '${AppearancePreferencesTable.columnId} = ?',
      whereArgs: [1],
      limit: 1,
    );
    if (rows.isNotEmpty) {
      return;
    }

    await _db.insert(AppearancePreferencesTable.name, {
      AppearancePreferencesTable.columnId: 1,
      AppearancePreferencesTable.columnThemeColor:
          AppearancePreferences.defaultThemeColorArgb,
      AppearancePreferencesTable.columnTextColor:
          LauncherTextColor.black.toStorage(),
      AppearancePreferencesTable.columnShowTileSeparators: 1,
      AppearancePreferencesTable.columnAppFont:
          LauncherAppFont.system.toStorage(),
    });
  }

  AppearancePreferences _fromRow(Map<String, Object?> row) {
    return AppearancePreferences(
      themeColorArgb: row[AppearancePreferencesTable.columnThemeColor]! as int,
      textColor: LauncherTextColor.fromStorage(
        row[AppearancePreferencesTable.columnTextColor]! as String,
      ),
      showTileSeparators:
          (row[AppearancePreferencesTable.columnShowTileSeparators] ?? 1) == 1,
      appFont: LauncherAppFont.fromStorage(
        row[AppearancePreferencesTable.columnAppFont] as String? ?? 'system',
      ),
    );
  }
}
