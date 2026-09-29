import 'package:bedrock_launcher/db/tables/favorite_app_table.dart';
import 'package:sqflite/sqflite.dart';

/// Initial schema — favorite apps pinned on the home screen.
Future<void> migration001(Database db) async {
  await db.execute(FavoriteAppTable.create);
  await db.execute(FavoriteAppTable.createDisplayOrderIndex);
}
