import 'package:bedrock_launcher/db/tables/appearance_preferences_table.dart';
import 'package:sqflite/sqflite.dart';

/// Adds app font selection to appearance preferences.
Future<void> migration004(Database db) async {
  await db.execute('''
ALTER TABLE ${AppearancePreferencesTable.name}
ADD COLUMN ${AppearancePreferencesTable.columnAppFont}
TEXT NOT NULL DEFAULT 'system'
''');
}
