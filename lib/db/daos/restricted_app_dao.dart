import 'package:bedrock_launcher/db/tables/restricted_app_table.dart';
import 'package:bedrock_launcher/domain/entities/restricted_app.dart';
import 'package:sqflite/sqflite.dart';

class RestrictedAppDao {
  RestrictedAppDao(this._db);

  final Database _db;

  Future<List<RestrictedApp>> getAll() async {
    final rows = await _db.query(
      RestrictedAppTable.name,
      orderBy: '${RestrictedAppTable.columnPackageName} ASC',
    );
    return rows.map(_fromRow).toList();
  }

  Future<void> replaceAll(Set<String> packageNames) async {
    await _db.transaction((txn) async {
      await txn.delete(RestrictedAppTable.name);
      final batch = txn.batch();
      for (final packageName in packageNames) {
        batch.insert(RestrictedAppTable.name, {
          RestrictedAppTable.columnPackageName: packageName,
        });
      }
      await batch.commit(noResult: true);
    });
  }

  RestrictedApp _fromRow(Map<String, Object?> row) {
    return RestrictedApp(
      packageName: row[RestrictedAppTable.columnPackageName]! as String,
    );
  }
}
