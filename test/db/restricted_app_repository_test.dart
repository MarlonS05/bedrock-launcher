import 'package:bedrock_launcher/db/app_database.dart';
import 'package:bedrock_launcher/repo/restricted_app_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  group('RestrictedApp persistence', () {
    late RestrictedAppRepositoryImpl repository;

    setUp(() async {
      final db = await openInMemoryAppDatabase(
        name: 'restricted_test_${DateTime.now().microsecondsSinceEpoch}',
      );
      addTearDown(db.close);
      repository = RestrictedAppRepositoryImpl(db);
    });

    test('replaceAll stores package names as primary keys', () async {
      await repository.replaceAll({
        'com.example.b',
        'com.example.a',
      });

      final apps = await repository.getAll();
      expect(
        apps.map((app) => app.packageName).toList(),
        ['com.example.a', 'com.example.b'],
      );
    });

    test('replaceAll clears previous rows', () async {
      await repository.replaceAll({'com.keep.me', 'com.remove.me'});
      await repository.replaceAll({'com.keep.me'});

      final apps = await repository.getAll();
      expect(apps.map((app) => app.packageName).toList(), ['com.keep.me']);
    });

    test('replaceAll with empty set clears the table', () async {
      await repository.replaceAll({'com.example.app'});
      await repository.replaceAll({});

      expect(await repository.getAll(), isEmpty);
    });
  });
}
