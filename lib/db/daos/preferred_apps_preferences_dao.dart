import 'package:bedrock_launcher/db/tables/preferred_apps_preferences_table.dart';
import 'package:bedrock_launcher/domain/entities/preferred_apps_preferences.dart';
import 'package:sqflite/sqflite.dart';

class PreferredAppsPreferencesDao {
  PreferredAppsPreferencesDao(this._db);

  final Database _db;

  Future<PreferredAppsPreferences> get() async {
    final rows = await _db.query(
      PreferredAppsPreferencesTable.name,
      where: '${PreferredAppsPreferencesTable.columnId} = ?',
      whereArgs: [1],
      limit: 1,
    );

    if (rows.isEmpty) {
      return PreferredAppsPreferences.defaults;
    }

    return _fromRow(rows.first);
  }

  Future<void> save(PreferredAppsPreferences preferences) async {
    await _ensureRowExists();
    await _db.update(
      PreferredAppsPreferencesTable.name,
      {
        PreferredAppsPreferencesTable.columnClockPackage:
            preferences.clockPackageName,
        PreferredAppsPreferencesTable.columnPhonePackage:
            preferences.phonePackageName,
        PreferredAppsPreferencesTable.columnCameraPackage:
            preferences.cameraPackageName,
        PreferredAppsPreferencesTable.columnGalleryPackage:
            preferences.galleryPackageName,
      },
      where: '${PreferredAppsPreferencesTable.columnId} = ?',
      whereArgs: [1],
    );
  }

  Future<void> _ensureRowExists() async {
    final rows = await _db.query(
      PreferredAppsPreferencesTable.name,
      where: '${PreferredAppsPreferencesTable.columnId} = ?',
      whereArgs: [1],
      limit: 1,
    );
    if (rows.isNotEmpty) {
      return;
    }

    await _db.insert(PreferredAppsPreferencesTable.name, {
      PreferredAppsPreferencesTable.columnId: 1,
    });
  }

  PreferredAppsPreferences _fromRow(Map<String, Object?> row) {
    return PreferredAppsPreferences(
      clockPackageName:
          row[PreferredAppsPreferencesTable.columnClockPackage] as String?,
      phonePackageName:
          row[PreferredAppsPreferencesTable.columnPhonePackage] as String?,
      cameraPackageName:
          row[PreferredAppsPreferencesTable.columnCameraPackage] as String?,
      galleryPackageName:
          row[PreferredAppsPreferencesTable.columnGalleryPackage] as String?,
    );
  }
}
