import 'package:bedrock_launcher/db/app_database.dart';
import 'package:bedrock_launcher/domain/entities/launcher_app.dart';
import 'package:bedrock_launcher/domain/services/installed_apps_port.dart';
import 'package:bedrock_launcher/domain/use_cases/list_installed_apps_use_case.dart';
import 'package:bedrock_launcher/domain/use_cases/prune_uninstalled_favorite_apps_use_case.dart';
import 'package:bedrock_launcher/domain/use_cases/reorder_favorite_apps_use_case.dart';
import 'package:bedrock_launcher/repo/favorite_app_repository_impl.dart';
import 'package:bedrock_launcher/repo/installed_apps_repository_impl.dart';
import 'package:bedrock_launcher/router/app_router.dart';
import 'package:bedrock_launcher/screens/settings/favorites/favorites_settings_bloc.dart';
import 'package:bedrock_launcher/screens/settings/favorites/favorites_settings_event.dart';
import 'package:bedrock_launcher/screens/settings/favorites/favorites_settings_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class _FakeAppRouter implements AppRouter {
  var popCount = 0;

  @override
  void goHome() {}

  @override
  Future<void> goAllApps() async {}

  @override
  Future<void> goSettings() async {}

  @override
  void goSettingsAppearance() {}

  @override
  void goSettingsPermissions() {}

  @override
  void goSettingsFavorites() {}

  @override
  void goSettingsPreferredApps() {}

  @override
  void goSettingsRestrictedApps() {}

  @override
  void pop() => popCount++;
}

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

  group('FavoritesSettingsBloc', () {
    late _FakeAppRouter appRouter;
    late FavoritesSettingsBloc bloc;
    late FavoriteAppRepositoryImpl repository;

    setUp(() async {
      appRouter = _FakeAppRouter();
      final db = await openInMemoryAppDatabase(
        name: 'favorites_bloc_${DateTime.now().microsecondsSinceEpoch}',
      );
      addTearDown(() async {
        await bloc.close();
        await db.close();
      });

      repository = FavoriteAppRepositoryImpl(db);
      bloc = FavoritesSettingsBloc(
        appRouter: appRouter,
        pruneUninstalledFavoriteAppsUseCase: PruneUninstalledFavoriteAppsUseCase(
          repository,
          ListInstalledAppsUseCase(
            InstalledAppsRepositoryImpl(
              _FakeInstalledAppsPort(const [
                LauncherApp(packageName: 'com.a.app', displayName: 'A'),
                LauncherApp(packageName: 'com.b.app', displayName: 'B'),
              ]),
            ),
          ),
        ),
        reorderFavoriteAppsUseCase: ReorderFavoriteAppsUseCase(repository),
      );
    });

    Future<void> pumpToLoaded() async {
      bloc.add(const FavoritesSettingsEvent.started());
      await bloc.stream.firstWhere(
        (state) => state.maybeMap(loaded: (_) => true, orElse: () => false),
      );
    }

    test('loads favorites in display order', () async {
      await repository.add('com.b.app');
      await repository.add('com.a.app');

      await pumpToLoaded();

      final loaded = bloc.state.mapOrNull(loaded: (value) => value);
      expect(
        loaded?.draftPackageNamesInOrder,
        ['com.b.app', 'com.a.app'],
      );
    });

    test('removes uninstalled favorites when loading', () async {
      await repository.add('com.a.app');
      await repository.add('com.b.app');
      await repository.add('com.removed.app');

      await pumpToLoaded();

      final loaded = bloc.state.mapOrNull(loaded: (value) => value);
      expect(
        loaded?.draftPackageNamesInOrder,
        ['com.a.app', 'com.b.app'],
      );

      final favorites = await repository.getAll();
      expect(
        favorites.map((favorite) => favorite.packageName).toList(),
        ['com.a.app', 'com.b.app'],
      );
    });

    test('back without changes pops immediately', () async {
      await pumpToLoaded();

      bloc.add(const FavoritesSettingsEvent.backTapped());
      await bloc.stream.firstWhere(
        (state) => state.maybeMap(closing: (_) => true, orElse: () => false),
      );

      expect(appRouter.popCount, 1);
    });

    test('back with unsaved changes pops without saving', () async {
      await repository.add('com.a.app');
      await repository.add('com.b.app');
      await pumpToLoaded();

      bloc.add(
        const FavoritesSettingsEvent.orderChanged(['com.b.app', 'com.a.app']),
      );
      await bloc.stream.firstWhere((state) => state.hasUnsavedChanges);

      bloc.add(const FavoritesSettingsEvent.backTapped());
      await bloc.stream.firstWhere(
        (state) => state.maybeMap(closing: (_) => true, orElse: () => false),
      );

      expect(appRouter.popCount, 1);

      final favorites = await repository.getAll();
      expect(
        favorites.map((favorite) => favorite.packageName).toList(),
        ['com.a.app', 'com.b.app'],
      );
    });

    test('save persists draft order and clears unsaved changes', () async {
      await repository.add('com.a.app');
      await repository.add('com.b.app');
      await pumpToLoaded();

      bloc.add(
        const FavoritesSettingsEvent.orderChanged(['com.b.app', 'com.a.app']),
      );
      await bloc.stream.firstWhere((state) => state.hasUnsavedChanges);

      bloc.add(const FavoritesSettingsEvent.saveTapped());
      await bloc.stream.firstWhere(
        (state) => state.maybeMap(
          loaded: (loaded) => !loaded.isSaving && !state.hasUnsavedChanges,
          orElse: () => false,
        ),
      );

      final loaded = bloc.state.mapOrNull(loaded: (value) => value);
      expect(
        loaded?.savedPackageNamesInOrder,
        ['com.b.app', 'com.a.app'],
      );
      expect(loaded?.draftPackageNamesInOrder, ['com.b.app', 'com.a.app']);
      expect(bloc.state.hasUnsavedChanges, isFalse);

      final favorites = await repository.getAll();
      expect(
        favorites.map((favorite) => favorite.packageName).toList(),
        ['com.b.app', 'com.a.app'],
      );
    });
  });
}
