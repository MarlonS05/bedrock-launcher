import 'package:bedrock_launcher/db/app_database.dart';
import 'package:bedrock_launcher/domain/entities/favorite_app.dart';
import 'package:bedrock_launcher/domain/exceptions/invalid_favorite_order_exception.dart';
import 'package:bedrock_launcher/repo/favorite_app_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  group('FavoriteApp persistence', () {
    late FavoriteAppRepositoryImpl repository;

    setUp(() async {
      final db = await openInMemoryAppDatabase(
        name: 'test_${DateTime.now().microsecondsSinceEpoch}',
      );
      addTearDown(db.close);
      repository = FavoriteAppRepositoryImpl(db);
    });

    test('stores packageName as the stable app identifier', () async {
      const packageName = 'com.example.testapp';

      final favorite = await repository.add(packageName);

      expect(favorite.packageName, packageName);
      expect(favorite.id, isNotNull);
      expect(favorite.order, 0);
    });

    test('getAll returns favorites sorted by order ascending', () async {
      await repository.add('com.third.app');
      await repository.add('com.first.app');
      await repository.reorder([
        'com.first.app',
        'com.third.app',
      ]);

      final favorites = await repository.getAll();

      expect(
        favorites.map((FavoriteApp f) => f.packageName).toList(),
        ['com.first.app', 'com.third.app'],
      );
      expect(favorites.map((FavoriteApp f) => f.order).toList(), [0, 1]);
    });

    test('add is idempotent for the same packageName', () async {
      const packageName = 'com.example.duplicate';

      final first = await repository.add(packageName);
      final second = await repository.add(packageName);

      expect(second, first);
      expect((await repository.getAll()).length, 1);
    });

    test('remove deletes a favorite by packageName', () async {
      await repository.add('com.example.toremove');
      await repository.remove('com.example.toremove');

      expect(await repository.getAll(), isEmpty);
    });

    test('reorder updates display order for all listed apps', () async {
      await repository.add('com.a.app');
      await repository.add('com.b.app');
      await repository.add('com.c.app');

      await repository.reorder([
        'com.c.app',
        'com.a.app',
        'com.b.app',
      ]);

      final favorites = await repository.getAll();
      expect(
        favorites.map((f) => f.packageName).toList(),
        ['com.c.app', 'com.a.app', 'com.b.app'],
      );
      expect(favorites.map((f) => f.order).toList(), [0, 1, 2]);
    });

    test('reorder rejects partial package lists', () async {
      await repository.add('com.a.app');
      await repository.add('com.b.app');

      await expectLater(
        repository.reorder(['com.a.app']),
        throwsA(isA<InvalidFavoriteOrderException>()),
      );

      final favorites = await repository.getAll();
      expect(
        favorites.map((f) => f.packageName).toList(),
        ['com.a.app', 'com.b.app'],
      );
    });

    test('reorder rejects unknown package names', () async {
      await repository.add('com.a.app');

      await expectLater(
        repository.reorder(['com.unknown.app']),
        throwsA(isA<InvalidFavoriteOrderException>()),
      );
    });

    test('reorder rejects duplicate package names', () async {
      await repository.add('com.a.app');
      await repository.add('com.b.app');

      await expectLater(
        repository.reorder(['com.a.app', 'com.a.app']),
        throwsA(isA<InvalidFavoriteOrderException>()),
      );
    });

    test('reorder allows empty list when there are no favorites', () async {
      await expectLater(repository.reorder([]), completes);
    });
  });
}
