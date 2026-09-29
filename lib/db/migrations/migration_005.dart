import 'package:bedrock_launcher/db/tables/preferred_apps_preferences_table.dart';
import 'package:sqflite/sqflite.dart';

/// Preferred apps — clock, phone, camera, gallery package names.
Future<void> migration005(Database db) async {
  await db.execute(PreferredAppsPreferencesTable.create);
  await db.insert(PreferredAppsPreferencesTable.name, {
    PreferredAppsPreferencesTable.columnId: 1,
  });
}
