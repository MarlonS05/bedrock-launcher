import 'package:bedrock_launcher/db/tables/restricted_app_table.dart';
import 'package:sqflite/sqflite.dart';

/// Restricted apps that require a math hurdle before launch.
Future<void> migration006(Database db) async {
  await db.execute(RestrictedAppTable.create);
}
