import 'package:bedrock_launcher/db/tables/appearance_preferences_table.dart';
import 'package:sqflite/sqflite.dart';

/// Adds tile separator visibility to appearance preferences.
Future<void> migration003(Database db) async {
  await db.execute('''
ALTER TABLE ${AppearancePreferencesTable.name}
ADD COLUMN ${AppearancePreferencesTable.columnShowTileSeparators}
INTEGER NOT NULL DEFAULT 1
''');
}
