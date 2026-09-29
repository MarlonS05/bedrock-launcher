import 'package:bedrock_launcher/db/tables/appearance_preferences_table.dart';
import 'package:bedrock_launcher/domain/entities/appearance_preferences.dart';
import 'package:bedrock_launcher/domain/entities/launcher_text_color.dart';
import 'package:sqflite/sqflite.dart';

/// Appearance preferences — theme color and text color.
Future<void> migration002(Database db) async {
  await db.execute(AppearancePreferencesTable.create);
  await db.insert(AppearancePreferencesTable.name, {
    AppearancePreferencesTable.columnId: 1,
    AppearancePreferencesTable.columnThemeColor:
        AppearancePreferences.defaultThemeColorArgb,
    AppearancePreferencesTable.columnTextColor:
        LauncherTextColor.black.toStorage(),
  });
}
