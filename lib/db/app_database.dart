import 'package:bedrock_launcher/db/migrations/migration_001.dart';
import 'package:bedrock_launcher/db/migrations/migration_002.dart';
import 'package:bedrock_launcher/db/migrations/migration_003.dart';
import 'package:bedrock_launcher/db/migrations/migration_004.dart';
import 'package:bedrock_launcher/db/migrations/migration_005.dart';
import 'package:bedrock_launcher/db/migrations/migration_006.dart';
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

const _databaseName = 'bedrock_launcher.db';
const _databaseVersion = 6;

Future<void> _runMigration(Database db, int version) async {
  switch (version) {
    case 1:
      await migration001(db);
    case 2:
      await migration002(db);
    case 3:
      await migration003(db);
    case 4:
      await migration004(db);
    case 5:
      await migration005(db);
    case 6:
      await migration006(db);
  }
}

/// Opens (or creates) the app SQLite database and runs migrations.
Future<Database> openAppDatabase({String? databasePath}) async {
  final path = databasePath ?? p.join(await getDatabasesPath(), _databaseName);

  return openDatabase(
    path,
    version: _databaseVersion,
    onCreate: (db, version) async {
      for (var v = 1; v <= version; v++) {
        await _runMigration(db, v);
      }
    },
    onUpgrade: (db, oldVersion, newVersion) async {
      for (var version = oldVersion + 1; version <= newVersion; version++) {
        await _runMigration(db, version);
      }
    },
  );
}

/// Opens an in-memory database for tests.
Future<Database> openInMemoryAppDatabase({String? name}) {
  return openDatabase(
    name ?? inMemoryDatabasePath,
    version: _databaseVersion,
    onCreate: (db, version) async {
      for (var v = 1; v <= version; v++) {
        await _runMigration(db, v);
      }
    },
  );
}
