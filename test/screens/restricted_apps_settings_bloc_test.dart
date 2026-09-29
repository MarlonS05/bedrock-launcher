import 'package:bedrock_launcher/db/app_database.dart';
import 'package:bedrock_launcher/domain/entities/launcher_app.dart';
import 'package:bedrock_launcher/domain/services/installed_apps_port.dart';
import 'package:bedrock_launcher/domain/use_cases/get_restricted_apps_use_case.dart';
import 'package:bedrock_launcher/domain/use_cases/list_installed_apps_use_case.dart';
import 'package:bedrock_launcher/domain/use_cases/replace_restricted_apps_use_case.dart';
import 'package:bedrock_launcher/repo/installed_apps_repository_impl.dart';
import 'package:bedrock_launcher/repo/restricted_app_repository_impl.dart';
import 'package:bedrock_launcher/router/app_router.dart';
import 'package:bedrock_launcher/screens/settings/restricted_apps/restricted_apps_settings_bloc.dart';
import 'package:bedrock_launcher/screens/settings/restricted_apps/restricted_apps_settings_event.dart';
import 'package:bedrock_launcher/screens/settings/restricted_apps/restricted_apps_settings_state.dart';
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

  group('RestrictedAppsSettingsBloc', () {
    late _FakeAppRouter appRouter;
    late RestrictedAppsSettingsBloc bloc;
    late RestrictedAppRepositoryImpl repository;

    setUp(() async {
      appRouter = _FakeAppRouter();
      final db = await openInMemoryAppDatabase(
        name: 'restricted_bloc_${DateTime.now().microsecondsSinceEpoch}',
      );
      addTearDown(() async {
        await bloc.close();
        await db.close();
      });

      repository = RestrictedAppRepositoryImpl(db);
      bloc = RestrictedAppsSettingsBloc(
        appRouter: appRouter,
        getRestrictedAppsUseCase: GetRestrictedAppsUseCase(repository),
        replaceRestrictedAppsUseCase: ReplaceRestrictedAppsUseCase(repository),
        listInstalledAppsUseCase: ListInstalledAppsUseCase(
          InstalledAppsRepositoryImpl(
            _FakeInstalledAppsPort(const [
              LauncherApp(packageName: 'com.b.app', displayName: 'B'),
              LauncherApp(packageName: 'com.a.app', displayName: 'A'),
            ]),
          ),
        ),
      );
    });

    Future<void> pumpToLoaded() async {
      bloc.add(const RestrictedAppsSettingsEvent.started());
      await bloc.stream.firstWhere(
        (state) => state.maybeMap(loaded: (_) => true, orElse: () => false),
      );
    }

    test('loads saved restricted apps and sorts installed apps by name',
        () async {
      await repository.replaceAll({'com.b.app'});

      await pumpToLoaded();

      final loaded = bloc.state.mapOrNull(loaded: (value) => value);
      expect(
        loaded?.installedApps.map((app) => app.packageName).toList(),
        ['com.a.app', 'com.b.app'],
      );
      expect(loaded?.savedRestrictedPackageNames, {'com.b.app'});
      expect(loaded?.draftRestrictedPackageNames, {'com.b.app'});
      expect(bloc.state.hasUnsavedChanges, isFalse);
    });

    test('toggling an app marks unsaved changes without persisting', () async {
      await pumpToLoaded();

      bloc.add(
        const RestrictedAppsSettingsEvent.restrictedAppToggled('com.a.app'),
      );
      await bloc.stream.firstWhere((state) => state.hasUnsavedChanges);

      final loaded = bloc.state.mapOrNull(loaded: (value) => value);
      expect(loaded?.draftRestrictedPackageNames, {'com.a.app'});
      expect(loaded?.savedRestrictedPackageNames, isEmpty);
      expect(await repository.getAll(), isEmpty);
    });

    test('toggling a checked app removes it from the draft', () async {
      await repository.replaceAll({'com.a.app'});
      await pumpToLoaded();

      bloc.add(
        const RestrictedAppsSettingsEvent.restrictedAppToggled('com.a.app'),
      );
      await bloc.stream.firstWhere((state) => state.hasUnsavedChanges);

      final loaded = bloc.state.mapOrNull(loaded: (value) => value);
      expect(loaded?.draftRestrictedPackageNames, isEmpty);
    });

    test('back with unsaved changes pops without saving', () async {
      await pumpToLoaded();

      bloc.add(
        const RestrictedAppsSettingsEvent.restrictedAppToggled('com.a.app'),
      );
      await bloc.stream.firstWhere((state) => state.hasUnsavedChanges);

      bloc.add(const RestrictedAppsSettingsEvent.backTapped());
      await bloc.stream.firstWhere(
        (state) => state.maybeMap(closing: (_) => true, orElse: () => false),
      );

      expect(appRouter.popCount, 1);
      expect(await repository.getAll(), isEmpty);
    });

    test('save persists the draft set and clears unsaved changes', () async {
      await pumpToLoaded();

      bloc.add(
        const RestrictedAppsSettingsEvent.restrictedAppToggled('com.a.app'),
      );
      await bloc.stream.firstWhere((state) => state.hasUnsavedChanges);

      bloc.add(const RestrictedAppsSettingsEvent.saveTapped());
      await bloc.stream.firstWhere(
        (state) => state.maybeMap(
          loaded: (loaded) => !loaded.isSaving && !state.hasUnsavedChanges,
          orElse: () => false,
        ),
      );

      final loaded = bloc.state.mapOrNull(loaded: (value) => value);
      expect(loaded?.savedRestrictedPackageNames, {'com.a.app'});
      expect(bloc.state.hasUnsavedChanges, isFalse);

      final restricted = await repository.getAll();
      expect(
        restricted.map((app) => app.packageName).toList(),
        ['com.a.app'],
      );
    });
  });
}
