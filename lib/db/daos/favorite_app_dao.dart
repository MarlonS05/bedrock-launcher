import 'package:bedrock_launcher/db/tables/favorite_app_table.dart';
import 'package:bedrock_launcher/domain/entities/favorite_app.dart';
import 'package:sqflite/sqflite.dart';

class FavoriteAppDao {
  FavoriteAppDao(this._db);

  final Database _db;

  Future<List<FavoriteApp>> getAllOrdered() async {
    final rows = await _db.query(
      FavoriteAppTable.name,
      orderBy: '${FavoriteAppTable.columnDisplayOrder} ASC',
    );
    return rows.map(_fromRow).toList();
  }

  Future<FavoriteApp?> findByPackageName(String packageName) async {
    final rows = await _db.query(
      FavoriteAppTable.name,
      where: '${FavoriteAppTable.columnPackageName} = ?',
      whereArgs: [packageName],
      limit: 1,
    );
    if (rows.isEmpty) {
      return null;
    }
    return _fromRow(rows.first);
  }

  Future<int> nextDisplayOrder() async {
    final result = await _db.rawQuery(
      'SELECT MAX(${FavoriteAppTable.columnDisplayOrder}) AS max_order '
      'FROM ${FavoriteAppTable.name}',
    );
    final maxOrder = result.first['max_order'] as int?;
    return (maxOrder ?? -1) + 1;
  }

  Future<FavoriteApp> insert({
    required String packageName,
    required int displayOrder,
  }) async {
    final id = await _db.insert(FavoriteAppTable.name, {
      FavoriteAppTable.columnPackageName: packageName,
      FavoriteAppTable.columnDisplayOrder: displayOrder,
    });
    return FavoriteApp(
      id: id,
      packageName: packageName,
      order: displayOrder,
    );
  }

  Future<void> deleteByPackageName(String packageName) {
    return _db.delete(
      FavoriteAppTable.name,
      where: '${FavoriteAppTable.columnPackageName} = ?',
      whereArgs: [packageName],
    );
  }

  Future<void> updateDisplayOrders(Map<String, int> orderByPackageName) async {
    final batch = _db.batch();
    for (final entry in orderByPackageName.entries) {
      batch.update(
        FavoriteAppTable.name,
        {FavoriteAppTable.columnDisplayOrder: entry.value},
        where: '${FavoriteAppTable.columnPackageName} = ?',
        whereArgs: [entry.key],
      );
    }
    await batch.commit(noResult: true);
  }

  FavoriteApp _fromRow(Map<String, Object?> row) {
    return FavoriteApp(
      id: row[FavoriteAppTable.columnId]! as int,
      packageName: row[FavoriteAppTable.columnPackageName]! as String,
      order: row[FavoriteAppTable.columnDisplayOrder]! as int,
    );
  }
}
