import 'package:bedrock_launcher/db/app_database.dart';
import 'package:bedrock_launcher/domain/entities/launcher_app.dart';
import 'package:bedrock_launcher/domain/services/installed_apps_port.dart';
import 'package:bedrock_launcher/domain/use_cases/list_installed_apps_use_case.dart';
import 'package:bedrock_launcher/domain/use_cases/prune_uninstalled_favorite_apps_use_case.dart';
import 'package:bedrock_launcher/repo/favorite_app_repository_impl.dart';
import 'package:bedrock_launcher/repo/installed_apps_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class _FakeInstalledAppsPort implements InstalledAppsPort {
  _FakeInstalledAppsPort(this._apps);

  final List<LauncherApp> _apps;

  @override
  Future<List<LauncherApp>> getInstalledApps() async => _apps;

  @override
  Future<void> openApp(String packageName) async {}

  @override
  Future<void> openAppSettings(String packageName) async {}

  @override
  Future<void> uninstallApp(String packageName) async {}
}

void main() {
  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  group('PruneUninstalledFavoriteAppsUseCase', () {
    late FavoriteAppRepositoryImpl repository;
    late PruneUninstalledFavoriteAppsUseCase useCase;

    setUp(() async {
      final db = await openInMemoryAppDatabase(
        name: 'prune_favorites_${DateTime.now().microsecondsSinceEpoch}',
      );
      addTearDown(db.close);

      repository = FavoriteAppRepositoryImpl(db);
      useCase = PruneUninstalledFavoriteAppsUseCase(
        repository,
        ListInstalledAppsUseCase(
          InstalledAppsRepositoryImpl(
            _FakeInstalledAppsPort(const [
              LauncherApp(packageName: 'com.a.app', displayName: 'A'),
              LauncherApp(packageName: 'com.c.app', displayName: 'C'),
            ]),
          ),
        ),
      );
    });

    test('removes favorites for apps that are no longer installed', () async {
      await repository.add('com.a.app');
      await repository.add('com.b.app');
      await repository.add('com.c.app');

      final favorites = await useCase();

      expect(
        favorites.map((favorite) => favorite.packageName).toList(),
        ['com.a.app', 'com.c.app'],
      );

      final persisted = await repository.getAll();
      expect(
        persisted.map((favorite) => favorite.packageName).toList(),
        ['com.a.app', 'com.c.app'],
      );
    });
  });
}
