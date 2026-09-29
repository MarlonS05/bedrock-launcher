import 'package:bedrock_launcher/db/app_database.dart';
import 'package:bedrock_launcher/domain/entities/installed_font.dart';
import 'package:bedrock_launcher/domain/entities/launcher_app.dart';
import 'package:bedrock_launcher/domain/services/installed_apps_port.dart';
import 'package:bedrock_launcher/domain/services/installed_fonts_port.dart';
import 'package:bedrock_launcher/domain/use_cases/add_favorite_app_use_case.dart';
import 'package:bedrock_launcher/domain/use_cases/get_appearance_preferences_use_case.dart';
import 'package:bedrock_launcher/domain/use_cases/get_favorite_apps_use_case.dart';
import 'package:bedrock_launcher/domain/use_cases/get_restricted_apps_use_case.dart';
import 'package:bedrock_launcher/domain/use_cases/launch_app_use_case.dart';
import 'package:bedrock_launcher/domain/use_cases/list_installed_apps_use_case.dart';
import 'package:bedrock_launcher/domain/use_cases/load_launcher_apps_use_case.dart';
import 'package:bedrock_launcher/domain/use_cases/open_app_settings_use_case.dart';
import 'package:bedrock_launcher/domain/use_cases/remove_favorite_app_use_case.dart';
import 'package:bedrock_launcher/domain/use_cases/uninstall_app_use_case.dart';
import 'package:bedrock_launcher/repo/appearance_preferences_repository_impl.dart';
import 'package:bedrock_launcher/repo/favorite_app_repository_impl.dart';
import 'package:bedrock_launcher/repo/installed_apps_repository_impl.dart';
import 'package:bedrock_launcher/repo/restricted_app_repository_impl.dart';
import 'package:bedrock_launcher/router/app_router.dart';
import 'package:bedrock_launcher/screens/all_apps/all_apps_bloc.dart';
import 'package:bedrock_launcher/screens/all_apps/all_apps_event.dart';
import 'package:bedrock_launcher/screens/all_apps/all_apps_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class _FakeAppRouter implements AppRouter {
  var popCount = 0;
  var goHomeCount = 0;

  @override
  void goHome() => goHomeCount++;

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
  var getInstalledAppsCount = 0;
  String? lastOpenedPackageName;
  String? lastAppSettingsPackageName;
  String? lastUninstallPackageName;

  @override
  Future<List<LauncherApp>> getInstalledApps() async {
    getInstalledAppsCount++;
    return _apps;
  }

  @override
  Future<void> openApp(String packageName) async {
    lastOpenedPackageName = packageName;
  }

  @override
  Future<void> openAppSettings(String packageName) async {
    lastAppSettingsPackageName = packageName;
  }

  @override
  Future<void> uninstallApp(String packageName) async {
    lastUninstallPackageName = packageName;
  }
}

class _FakeInstalledFontsPort implements InstalledFontsPort {
  @override
  Future<List<InstalledFont>> listFonts() async => const [];

  @override
  Future<void> loadFont(String familyId) async {}
}

Future<({
  AllAppsBloc bloc,
  _FakeAppRouter appRouter,
  _FakeInstalledAppsPort installedAppsPort,
})> _createBloc({
  required List<LauncherApp> apps,
  required Database db,
}) async {
  final installedAppsPort = _FakeInstalledAppsPort(apps);
  final installedAppsRepository =
      InstalledAppsRepositoryImpl(installedAppsPort);
  final favoriteRepository = FavoriteAppRepositoryImpl(db);
  final restrictedRepository = RestrictedAppRepositoryImpl(db);
  final appRouter = _FakeAppRouter();

  final bloc = AllAppsBloc(
    appRouter: appRouter,
    getAppearancePreferencesUseCase: GetAppearancePreferencesUseCase(
      AppearancePreferencesRepositoryImpl(db),
    ),
    loadLauncherAppsUseCase: LoadLauncherAppsUseCase(
      ListInstalledAppsUseCase(installedAppsRepository),
      GetFavoriteAppsUseCase(favoriteRepository),
      GetRestrictedAppsUseCase(restrictedRepository),
    ),
    launchAppUseCase: LaunchAppUseCase(installedAppsPort),
    addFavoriteAppUseCase: AddFavoriteAppUseCase(favoriteRepository),
    removeFavoriteAppUseCase: RemoveFavoriteAppUseCase(favoriteRepository),
    uninstallAppUseCase: UninstallAppUseCase(
      installedAppsPort,
      installedAppsRepository,
    ),
    openAppSettingsUseCase: OpenAppSettingsUseCase(installedAppsPort),
    installedFontsPort: _FakeInstalledFontsPort(),
  );

  return (
    bloc: bloc,
    appRouter: appRouter,
    installedAppsPort: installedAppsPort,
  );
}

Future<void> _waitForAppsLoaded(AllAppsBloc bloc) {
  return bloc.stream.firstWhere(
    (state) =>
        state.mapOrNull(loaded: (loaded) => !loaded.isAppsLoading) ?? false,
  );
}

void main() {
  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  test('started loads installed apps with appearance preferences and favorites',
      () async {
    final db = await openInMemoryAppDatabase(
      name: 'all_apps_bloc_test_${DateTime.now().microsecondsSinceEpoch}',
    );
    addTearDown(db.close);

    final favoriteRepository = FavoriteAppRepositoryImpl(db);
    await favoriteRepository.add('com.chrome');

    final setup = await _createBloc(
      db: db,
      apps: const [
        LauncherApp(packageName: 'com.chrome', displayName: 'Chrome'),
        LauncherApp(packageName: 'com.camera', displayName: 'Camera'),
      ],
    );

    setup.bloc.add(const AllAppsEvent.started());
    await expectLater(
      setup.bloc.stream,
      emitsInOrder([
        const AllAppsState.loading(),
        isA<AllAppsState>().having(
          (state) => state.mapOrNull(
            loaded: (loaded) =>
                loaded.allApps.isEmpty &&
                loaded.filteredApps.isEmpty &&
                loaded.isAppsLoading,
          ),
          'loaded shell while apps are loading',
          true,
        ),
        isA<AllAppsState>().having(
          (state) => state.mapOrNull(
            loaded: (loaded) =>
                loaded.allApps.length == 2 &&
                loaded.filteredApps.length == 2 &&
                loaded.searchQuery.isEmpty &&
                !loaded.isAppsLoading &&
                loaded.favoritePackageNames.contains('com.chrome'),
          ),
          'loaded state with all apps and favorites',
          true,
        ),
      ]),
    );

    await setup.bloc.close();
  });

  test('searchQueryChanged filters apps by display name', () async {
    final db = await openInMemoryAppDatabase(
      name: 'all_apps_search_test_${DateTime.now().microsecondsSinceEpoch}',
    );
    addTearDown(db.close);

    final setup = await _createBloc(
      db: db,
      apps: const [
        LauncherApp(packageName: 'com.chrome', displayName: 'Chrome'),
        LauncherApp(packageName: 'com.camera', displayName: 'Camera'),
        LauncherApp(packageName: 'com.messages', displayName: 'Messages'),
      ],
    );

    setup.bloc.add(const AllAppsEvent.started());
    await _waitForAppsLoaded(setup.bloc);

    setup.bloc.add(const AllAppsEvent.searchQueryChanged('cam'));
    await expectLater(
      setup.bloc.stream,
      emits(
        isA<AllAppsState>().having(
          (state) => state.mapOrNull(
            loaded: (loaded) =>
                loaded.searchQuery == 'cam' &&
                loaded.filteredApps.length == 1 &&
                loaded.filteredApps.first.displayName == 'Camera',
          ),
          'filtered to Camera',
          true,
        ),
      ),
    );

    await setup.bloc.close();
  });

  test('appTapped delegates to launch use case', () async {
    final db = await openInMemoryAppDatabase(
      name: 'all_apps_launch_test_${DateTime.now().microsecondsSinceEpoch}',
    );
    addTearDown(db.close);

    final setup = await _createBloc(
      db: db,
      apps: const [
        LauncherApp(packageName: 'com.chrome', displayName: 'Chrome'),
      ],
    );

    setup.bloc.add(const AllAppsEvent.started());
    await _waitForAppsLoaded(setup.bloc);

    setup.bloc.add(const AllAppsEvent.appTapped('com.chrome'));
    await Future<void>.delayed(Duration.zero);

    expect(setup.installedAppsPort.lastOpenedPackageName, 'com.chrome');
    expect(setup.appRouter.goHomeCount, 1);

    await setup.bloc.close();
  });

  test('searchSubmitted launches top filtered app when query matches',
      () async {
    final db = await openInMemoryAppDatabase(
      name:
          'all_apps_search_submit_test_${DateTime.now().microsecondsSinceEpoch}',
    );
    addTearDown(db.close);

    final setup = await _createBloc(
      db: db,
      apps: const [
        LauncherApp(packageName: 'com.chrome', displayName: 'Chrome'),
        LauncherApp(packageName: 'com.camera', displayName: 'Camera'),
        LauncherApp(packageName: 'com.messages', displayName: 'Messages'),
      ],
    );

    setup.bloc.add(const AllAppsEvent.started());
    await _waitForAppsLoaded(setup.bloc);

    setup.bloc.add(const AllAppsEvent.searchQueryChanged('cam'));
    await setup.bloc.stream.firstWhere(
      (state) =>
          state.mapOrNull(loaded: (l) => l.searchQuery == 'cam') ?? false,
    );

    setup.bloc.add(const AllAppsEvent.searchSubmitted());
    await Future<void>.delayed(Duration.zero);

    expect(setup.installedAppsPort.lastOpenedPackageName, 'com.camera');
    expect(setup.appRouter.goHomeCount, 1);

    await setup.bloc.close();
  });

  test('searchSubmitted does nothing when query is empty', () async {
    final db = await openInMemoryAppDatabase(
      name:
          'all_apps_search_submit_empty_test_${DateTime.now().microsecondsSinceEpoch}',
    );
    addTearDown(db.close);

    final setup = await _createBloc(
      db: db,
      apps: const [
        LauncherApp(packageName: 'com.chrome', displayName: 'Chrome'),
      ],
    );

    setup.bloc.add(const AllAppsEvent.started());
    await _waitForAppsLoaded(setup.bloc);

    setup.bloc.add(const AllAppsEvent.searchSubmitted());
    await Future<void>.delayed(Duration.zero);

    expect(setup.installedAppsPort.lastOpenedPackageName, isNull);
    expect(setup.appRouter.goHomeCount, 0);

    await setup.bloc.close();
  });

  test('favoriteToggled adds and removes favorites', () async {
    final db = await openInMemoryAppDatabase(
      name: 'all_apps_favorite_test_${DateTime.now().microsecondsSinceEpoch}',
    );
    addTearDown(db.close);

    final setup = await _createBloc(
      db: db,
      apps: const [
        LauncherApp(packageName: 'com.chrome', displayName: 'Chrome'),
      ],
    );

    setup.bloc.add(const AllAppsEvent.started());
    await _waitForAppsLoaded(setup.bloc);

    setup.bloc.add(const AllAppsEvent.favoriteToggled('com.chrome'));
    await expectLater(
      setup.bloc.stream,
      emits(
        isA<AllAppsState>().having(
          (state) => state.mapOrNull(
            loaded: (loaded) =>
                loaded.favoritePackageNames.contains('com.chrome'),
          ),
          'favorite added',
          true,
        ),
      ),
    );

    setup.bloc.add(const AllAppsEvent.favoriteToggled('com.chrome'));
    await expectLater(
      setup.bloc.stream,
      emits(
        isA<AllAppsState>().having(
          (state) => state.mapOrNull(
            loaded: (loaded) =>
                !loaded.favoritePackageNames.contains('com.chrome'),
          ),
          'favorite removed',
          true,
        ),
      ),
    );

    await setup.bloc.close();
  });

  test('uninstallTapped delegates to uninstall use case', () async {
    final db = await openInMemoryAppDatabase(
      name: 'all_apps_uninstall_test_${DateTime.now().microsecondsSinceEpoch}',
    );
    addTearDown(db.close);

    final setup = await _createBloc(
      db: db,
      apps: const [
        LauncherApp(packageName: 'com.chrome', displayName: 'Chrome'),
      ],
    );

    setup.bloc.add(const AllAppsEvent.started());
    await _waitForAppsLoaded(setup.bloc);

    setup.bloc.add(const AllAppsEvent.uninstallTapped('com.chrome'));
    await Future<void>.delayed(Duration.zero);

    expect(setup.installedAppsPort.lastUninstallPackageName, 'com.chrome');

    await setup.bloc.close();
  });

  test('openAppSettingsTapped delegates to open app settings use case',
      () async {
    final db = await openInMemoryAppDatabase(
      name: 'all_apps_settings_test_${DateTime.now().microsecondsSinceEpoch}',
    );
    addTearDown(db.close);

    final setup = await _createBloc(
      db: db,
      apps: const [
        LauncherApp(packageName: 'com.chrome', displayName: 'Chrome'),
      ],
    );

    setup.bloc.add(const AllAppsEvent.started());
    await _waitForAppsLoaded(setup.bloc);

    setup.bloc.add(const AllAppsEvent.openAppSettingsTapped('com.chrome'));
    await Future<void>.delayed(Duration.zero);

    expect(setup.installedAppsPort.lastAppSettingsPackageName, 'com.chrome');

    await setup.bloc.close();
  });

  test('resumed reloads apps while preserving search query', () async {
    final db = await openInMemoryAppDatabase(
      name: 'all_apps_resumed_test_${DateTime.now().microsecondsSinceEpoch}',
    );
    addTearDown(db.close);

    final favoriteRepository = FavoriteAppRepositoryImpl(db);

    final setup = await _createBloc(
      db: db,
      apps: const [
        LauncherApp(packageName: 'com.chrome', displayName: 'Chrome'),
        LauncherApp(packageName: 'com.camera', displayName: 'Camera'),
      ],
    );

    setup.bloc.add(const AllAppsEvent.started());
    await _waitForAppsLoaded(setup.bloc);

    setup.bloc.add(const AllAppsEvent.searchQueryChanged('cam'));
    await setup.bloc.stream.firstWhere(
      (state) =>
          state.mapOrNull(loaded: (loaded) => loaded.searchQuery == 'cam') ??
          false,
    );

    await favoriteRepository.add('com.camera');

    setup.bloc.add(const AllAppsEvent.resumed());
    await expectLater(
      setup.bloc.stream,
      emitsInOrder([
        isA<AllAppsState>().having(
          (state) => state.mapOrNull(
            loaded: (loaded) =>
                loaded.searchQuery == 'cam' && loaded.isAppsLoading,
          ),
          'resumed sets isAppsLoading without loading state',
          true,
        ),
        isA<AllAppsState>().having(
          (state) => state.mapOrNull(
            loaded: (loaded) =>
                loaded.searchQuery == 'cam' &&
                loaded.filteredApps.length == 1 &&
                loaded.filteredApps.first.displayName == 'Camera' &&
                !loaded.isAppsLoading &&
                loaded.favoritePackageNames.contains('com.camera'),
          ),
          'resumed with preserved search and refreshed favorites',
          true,
        ),
      ]),
    );

    await setup.bloc.close();
  });

  test('refreshTapped bypasses the installed apps cache', () async {
    final db = await openInMemoryAppDatabase(
      name: 'all_apps_refresh_test_${DateTime.now().microsecondsSinceEpoch}',
    );
    addTearDown(db.close);

    final setup = await _createBloc(
      db: db,
      apps: const [
        LauncherApp(packageName: 'com.chrome', displayName: 'Chrome'),
        LauncherApp(packageName: 'com.camera', displayName: 'Camera'),
      ],
    );

    setup.bloc.add(const AllAppsEvent.started());
    await _waitForAppsLoaded(setup.bloc);
    expect(setup.installedAppsPort.getInstalledAppsCount, 1);

    setup.bloc.add(const AllAppsEvent.searchQueryChanged('cam'));
    await setup.bloc.stream.firstWhere(
      (state) =>
          state.mapOrNull(loaded: (loaded) => loaded.searchQuery == 'cam') ??
          false,
    );

    setup.bloc.add(const AllAppsEvent.refreshTapped());
    await expectLater(
      setup.bloc.stream,
      emitsInOrder([
        isA<AllAppsState>().having(
          (state) => state.mapOrNull(
            loaded: (loaded) =>
                loaded.searchQuery == 'cam' && loaded.isAppsLoading,
          ),
          'refresh sets isAppsLoading',
          true,
        ),
        isA<AllAppsState>().having(
          (state) => state.mapOrNull(
            loaded: (loaded) =>
                loaded.searchQuery == 'cam' && !loaded.isAppsLoading,
          ),
          'refresh keeps the search query',
          true,
        ),
      ]),
    );
    expect(setup.installedAppsPort.getInstalledAppsCount, 2);

    await setup.bloc.close();
  });

  test('searchQueryChanged during isAppsLoading is preserved when apps arrive',
      () async {
    final db = await openInMemoryAppDatabase(
      name:
          'all_apps_search_during_load_test_${DateTime.now().microsecondsSinceEpoch}',
    );
    addTearDown(db.close);

    final setup = await _createBloc(
      db: db,
      apps: const [
        LauncherApp(packageName: 'com.chrome', displayName: 'Chrome'),
        LauncherApp(packageName: 'com.camera', displayName: 'Camera'),
      ],
    );

    setup.bloc.add(const AllAppsEvent.started());
    await setup.bloc.stream.firstWhere(
      (state) =>
          state.mapOrNull(loaded: (loaded) => loaded.isAppsLoading) ?? false,
    );

    setup.bloc.add(const AllAppsEvent.searchQueryChanged('cam'));
    await setup.bloc.stream.firstWhere(
      (state) =>
          state.mapOrNull(loaded: (loaded) => loaded.searchQuery == 'cam') ??
          false,
    );

    await expectLater(
      setup.bloc.stream,
      emits(
        isA<AllAppsState>().having(
          (state) => state.mapOrNull(
            loaded: (loaded) =>
                loaded.searchQuery == 'cam' &&
                loaded.filteredApps.length == 1 &&
                loaded.filteredApps.first.displayName == 'Camera' &&
                !loaded.isAppsLoading,
          ),
          'search query preserved after apps load',
          true,
        ),
      ),
    );

    await setup.bloc.close();
  });

  test('appTapped sets pending challenge for restricted apps', () async {
    final db = await openInMemoryAppDatabase(
      name:
          'all_apps_restricted_launch_test_${DateTime.now().microsecondsSinceEpoch}',
    );
    addTearDown(db.close);

    await RestrictedAppRepositoryImpl(db).replaceAll({'com.chrome'});

    final setup = await _createBloc(
      db: db,
      apps: const [
        LauncherApp(packageName: 'com.chrome', displayName: 'Chrome'),
      ],
    );

    setup.bloc.add(const AllAppsEvent.started());
    await _waitForAppsLoaded(setup.bloc);

    setup.bloc.add(const AllAppsEvent.appTapped('com.chrome'));
    await expectLater(
      setup.bloc.stream,
      emits(
        isA<AllAppsState>().having(
          (state) => state.mapOrNull(
            loaded: (loaded) => loaded.pendingRestrictedLaunchPackageName,
          ),
          'pending package',
          'com.chrome',
        ),
      ),
    );
    expect(setup.installedAppsPort.lastOpenedPackageName, isNull);
    expect(setup.appRouter.goHomeCount, 0);

    setup.bloc.add(const AllAppsEvent.restrictedLaunchConfirmed());
    await Future<void>.delayed(Duration.zero);
    expect(setup.installedAppsPort.lastOpenedPackageName, 'com.chrome');
    expect(setup.appRouter.goHomeCount, 1);

    await setup.bloc.close();
  });
}
