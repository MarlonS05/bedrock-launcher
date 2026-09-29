import 'package:bedrock_launcher/db/app_database.dart';
import 'package:bedrock_launcher/domain/entities/installed_font.dart';
import 'package:bedrock_launcher/domain/entities/launcher_app.dart';
import 'package:bedrock_launcher/domain/services/battery_port.dart';
import 'package:bedrock_launcher/domain/services/default_browser_port.dart';
import 'package:bedrock_launcher/domain/services/installed_fonts_port.dart';
import 'package:bedrock_launcher/domain/services/system_apps_port.dart';
import 'package:bedrock_launcher/domain/services/installed_apps_port.dart';
import 'package:bedrock_launcher/domain/use_cases/get_appearance_preferences_use_case.dart';
import 'package:bedrock_launcher/domain/use_cases/get_battery_level_use_case.dart';
import 'package:bedrock_launcher/domain/use_cases/get_favorite_apps_use_case.dart';
import 'package:bedrock_launcher/domain/use_cases/get_preferred_apps_preferences_use_case.dart';
import 'package:bedrock_launcher/domain/use_cases/get_restricted_apps_use_case.dart';
import 'package:bedrock_launcher/domain/use_cases/launch_app_use_case.dart';
import 'package:bedrock_launcher/domain/use_cases/list_installed_apps_use_case.dart';
import 'package:bedrock_launcher/domain/use_cases/load_launcher_apps_use_case.dart';
import 'package:bedrock_launcher/domain/use_cases/open_camera_use_case.dart';
import 'package:bedrock_launcher/domain/use_cases/open_gallery_use_case.dart';
import 'package:bedrock_launcher/domain/use_cases/open_clock_use_case.dart';
import 'package:bedrock_launcher/domain/use_cases/open_default_browser_use_case.dart';
import 'package:bedrock_launcher/domain/use_cases/open_dialer_use_case.dart';
import 'package:bedrock_launcher/repo/appearance_preferences_repository_impl.dart';
import 'package:bedrock_launcher/repo/favorite_app_repository_impl.dart';
import 'package:bedrock_launcher/repo/installed_apps_repository_impl.dart';
import 'package:bedrock_launcher/repo/preferred_apps_preferences_repository_impl.dart';
import 'package:bedrock_launcher/repo/restricted_app_repository_impl.dart';
import 'package:bedrock_launcher/router/app_router.dart';
import 'package:bedrock_launcher/screens/home/home_bloc.dart';
import 'package:bedrock_launcher/screens/home/home_event.dart';
import 'package:bedrock_launcher/screens/home/home_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class _FakeAppRouter implements AppRouter {
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
  void pop() {}
}

class _FakeInstalledAppsPort implements InstalledAppsPort {
  _FakeInstalledAppsPort(this._apps);

  final List<LauncherApp> _apps;
  String? lastOpenedPackageName;

  @override
  Future<List<LauncherApp>> getInstalledApps() async => _apps;

  @override
  Future<void> openApp(String packageName) async {
    lastOpenedPackageName = packageName;
  }

  @override
  Future<void> openAppSettings(String packageName) async {}

  @override
  Future<void> uninstallApp(String packageName) async {}
}

class _FakeDefaultBrowserPort implements DefaultBrowserPort {
  var openCount = 0;

  @override
  Future<void> openDefaultBrowser() async {
    openCount++;
  }
}

class _FakeSystemAppsPort implements SystemAppsPort {
  var dialerOpenCount = 0;
  var cameraOpenCount = 0;
  var galleryOpenCount = 0;
  var clockOpenCount = 0;

  @override
  Future<void> openDialer() async {
    dialerOpenCount++;
  }

  @override
  Future<void> openCamera() async {
    cameraOpenCount++;
  }

  @override
  Future<void> openGallery() async {
    galleryOpenCount++;
  }

  @override
  Future<void> openClock() async {
    clockOpenCount++;
  }
}

class _FakeBatteryPort implements BatteryPort {
  _FakeBatteryPort(this._level);

  int _level;
  var readCount = 0;

  void setLevel(int level) => _level = level;

  @override
  Future<int> getBatteryLevel() async {
    readCount++;
    return _level;
  }
}

class _FakeInstalledFontsPort implements InstalledFontsPort {
  @override
  Future<List<InstalledFont>> listFonts() async => const [];

  @override
  Future<void> loadFont(String familyId) async {}
}

Future<
  ({
    HomeBloc bloc,
    _FakeInstalledAppsPort installedAppsPort,
    _FakeDefaultBrowserPort defaultBrowserPort,
    _FakeSystemAppsPort systemAppsPort,
    _FakeBatteryPort batteryPort,
  })
> _createBloc({
  required Database db,
  required List<LauncherApp> apps,
  int batteryLevel = 75,
}) async {
  final installedAppsPort = _FakeInstalledAppsPort(apps);
  final installedAppsRepository = InstalledAppsRepositoryImpl(installedAppsPort);
  final defaultBrowserPort = _FakeDefaultBrowserPort();
  final systemAppsPort = _FakeSystemAppsPort();
  final batteryPort = _FakeBatteryPort(batteryLevel);
  final favoriteRepository = FavoriteAppRepositoryImpl(db);
  final restrictedRepository = RestrictedAppRepositoryImpl(db);
  final getPreferredAppsPreferencesUseCase = GetPreferredAppsPreferencesUseCase(
    PreferredAppsPreferencesRepositoryImpl(db),
  );
  final launchAppUseCase = LaunchAppUseCase(installedAppsPort);

  final bloc = HomeBloc(
    appRouter: _FakeAppRouter(),
    getAppearancePreferencesUseCase: GetAppearancePreferencesUseCase(
      AppearancePreferencesRepositoryImpl(db),
    ),
    getPreferredAppsPreferencesUseCase: getPreferredAppsPreferencesUseCase,
    loadLauncherAppsUseCase: LoadLauncherAppsUseCase(
      ListInstalledAppsUseCase(installedAppsRepository),
      GetFavoriteAppsUseCase(favoriteRepository),
      GetRestrictedAppsUseCase(restrictedRepository),
    ),
    getBatteryLevelUseCase: GetBatteryLevelUseCase(batteryPort),
    launchAppUseCase: launchAppUseCase,
    openDefaultBrowserUseCase: OpenDefaultBrowserUseCase(defaultBrowserPort),
    openDialerUseCase: OpenDialerUseCase(
      systemAppsPort,
      getPreferredAppsPreferencesUseCase,
      launchAppUseCase,
    ),
    openCameraUseCase: OpenCameraUseCase(
      systemAppsPort,
      getPreferredAppsPreferencesUseCase,
      launchAppUseCase,
    ),
    openGalleryUseCase: OpenGalleryUseCase(
      systemAppsPort,
      getPreferredAppsPreferencesUseCase,
      launchAppUseCase,
    ),
    openClockUseCase: OpenClockUseCase(
      systemAppsPort,
      getPreferredAppsPreferencesUseCase,
      launchAppUseCase,
    ),
    installedFontsPort: _FakeInstalledFontsPort(),
  );

  return (
    bloc: bloc,
    installedAppsPort: installedAppsPort,
    defaultBrowserPort: defaultBrowserPort,
    systemAppsPort: systemAppsPort,
    batteryPort: batteryPort,
  );
}

void main() {
  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  test('started loads favorited installed apps in display order', () async {
    final db = await openInMemoryAppDatabase(
      name: 'home_bloc_test_${DateTime.now().microsecondsSinceEpoch}',
    );
    addTearDown(db.close);

    final favoriteRepository = FavoriteAppRepositoryImpl(db);
    await favoriteRepository.add('com.camera');
    await favoriteRepository.add('com.chrome');

    final setup = await _createBloc(
      db: db,
      apps: const [
        LauncherApp(packageName: 'com.chrome', displayName: 'Chrome'),
        LauncherApp(packageName: 'com.camera', displayName: 'Camera'),
        LauncherApp(packageName: 'com.messages', displayName: 'Messages'),
      ],
    );

    setup.bloc.add(const HomeEvent.started());
    await expectLater(
      setup.bloc.stream,
      emitsInOrder([
        const HomeState.loading(),
        isA<HomeState>()
            .having(
              (state) => state.mapOrNull(
                loaded: (loaded) =>
                    loaded.apps.map((app) => app.packageName).toList(),
              ),
              'favorite apps in order',
              ['com.camera', 'com.chrome'],
            )
            .having(
              (state) =>
                  state.mapOrNull(loaded: (loaded) => loaded.batteryLevel),
              'battery level',
              75,
            ),
      ]),
    );

    await setup.bloc.close();
  });

  test('started shows empty list when no favorites are saved', () async {
    final db = await openInMemoryAppDatabase(
      name: 'home_bloc_test_empty_${DateTime.now().microsecondsSinceEpoch}',
    );
    addTearDown(db.close);

    final setup = await _createBloc(
      db: db,
      apps: const [
        LauncherApp(packageName: 'com.chrome', displayName: 'Chrome'),
      ],
    );

    setup.bloc.add(const HomeEvent.started());
    await expectLater(
      setup.bloc.stream,
      emitsInOrder([
        const HomeState.loading(),
        isA<HomeState>().having(
          (state) => state.mapOrNull(loaded: (loaded) => loaded.apps),
          'empty favorite list',
          isEmpty,
        ),
      ]),
    );

    await setup.bloc.close();
  });

  test('appTapped launches the selected favorite app', () async {
    final db = await openInMemoryAppDatabase(
      name: 'home_bloc_test_launch_${DateTime.now().microsecondsSinceEpoch}',
    );
    addTearDown(db.close);

    final favoriteRepository = FavoriteAppRepositoryImpl(db);
    await favoriteRepository.add('com.chrome');

    final setup = await _createBloc(
      db: db,
      apps: const [
        LauncherApp(packageName: 'com.chrome', displayName: 'Chrome'),
      ],
    );

    setup.bloc.add(const HomeEvent.started());
    await setup.bloc.stream.firstWhere(
      (state) => state.mapOrNull(loaded: (_) => true) ?? false,
    );

    setup.bloc.add(const HomeEvent.appTapped(0));
    await Future<void>.delayed(Duration.zero);

    expect(setup.installedAppsPort.lastOpenedPackageName, 'com.chrome');

    await setup.bloc.close();
  });

  test('phoneTapped opens the dialer', () async {
    final db = await openInMemoryAppDatabase(
      name: 'home_bloc_test_phone_${DateTime.now().microsecondsSinceEpoch}',
    );
    addTearDown(db.close);

    final setup = await _createBloc(
      db: db,
      apps: const [
        LauncherApp(packageName: 'com.chrome', displayName: 'Chrome'),
      ],
    );

    setup.bloc.add(const HomeEvent.phoneTapped());
    await pumpEventQueue();

    expect(setup.systemAppsPort.dialerOpenCount, 1);

    await setup.bloc.close();
  });

  test('clockTapped opens the clock', () async {
    final db = await openInMemoryAppDatabase(
      name: 'home_bloc_test_clock_${DateTime.now().microsecondsSinceEpoch}',
    );
    addTearDown(db.close);

    final setup = await _createBloc(
      db: db,
      apps: const [
        LauncherApp(packageName: 'com.chrome', displayName: 'Chrome'),
      ],
    );

    setup.bloc.add(const HomeEvent.clockTapped());
    await pumpEventQueue();

    expect(setup.systemAppsPort.clockOpenCount, 1);

    await setup.bloc.close();
  });

  test('cameraTapped opens the camera', () async {
    final db = await openInMemoryAppDatabase(
      name: 'home_bloc_test_camera_${DateTime.now().microsecondsSinceEpoch}',
    );
    addTearDown(db.close);

    final setup = await _createBloc(
      db: db,
      apps: const [
        LauncherApp(packageName: 'com.chrome', displayName: 'Chrome'),
      ],
    );

    setup.bloc.add(const HomeEvent.cameraTapped());
    await pumpEventQueue();

    expect(setup.systemAppsPort.cameraOpenCount, 1);

    await setup.bloc.close();
  });

  test('cameraLongPressed opens the gallery', () async {
    final db = await openInMemoryAppDatabase(
      name: 'home_bloc_test_gallery_${DateTime.now().microsecondsSinceEpoch}',
    );
    addTearDown(db.close);

    final setup = await _createBloc(
      db: db,
      apps: const [
        LauncherApp(packageName: 'com.chrome', displayName: 'Chrome'),
      ],
    );

    setup.bloc.add(const HomeEvent.cameraLongPressed());
    await pumpEventQueue();

    expect(setup.systemAppsPort.galleryOpenCount, 1);

    await setup.bloc.close();
  });

  test('browserSwipeUpDetected opens the default browser', () async {
    final db = await openInMemoryAppDatabase(
      name: 'home_bloc_test_browser_${DateTime.now().microsecondsSinceEpoch}',
    );
    addTearDown(db.close);

    final setup = await _createBloc(
      db: db,
      apps: const [
        LauncherApp(packageName: 'com.chrome', displayName: 'Chrome'),
      ],
    );

    setup.bloc.add(const HomeEvent.browserSwipeUpDetected());
    await Future<void>.delayed(Duration.zero);

    expect(setup.defaultBrowserPort.openCount, 1);

    await setup.bloc.close();
  });

  test('batteryRefreshRequested updates battery level in loaded state', () async {
    final db = await openInMemoryAppDatabase(
      name: 'home_bloc_test_battery_${DateTime.now().microsecondsSinceEpoch}',
    );
    addTearDown(db.close);

    final setup = await _createBloc(
      db: db,
      apps: const [
        LauncherApp(packageName: 'com.chrome', displayName: 'Chrome'),
      ],
      batteryLevel: 42,
    );

    setup.bloc.add(const HomeEvent.started());
    await setup.bloc.stream.firstWhere(
      (state) => state.mapOrNull(loaded: (_) => true) ?? false,
    );

    expect(setup.batteryPort.readCount, 1);

    setup.batteryPort.setLevel(88);
    setup.bloc.add(const HomeEvent.batteryRefreshRequested());
    await expectLater(
      setup.bloc.stream,
      emits(
        isA<HomeState>().having(
          (state) => state.mapOrNull(loaded: (loaded) => loaded.batteryLevel),
          'refreshed battery level',
          88,
        ),
      ),
    );

    expect(setup.batteryPort.readCount, 2);

    await setup.bloc.close();
  });

  test('appTapped sets pending challenge for restricted favorites', () async {
    final db = await openInMemoryAppDatabase(
      name:
          'home_bloc_test_restricted_${DateTime.now().microsecondsSinceEpoch}',
    );
    addTearDown(db.close);

    final favoriteRepository = FavoriteAppRepositoryImpl(db);
    await favoriteRepository.add('com.chrome');
    await RestrictedAppRepositoryImpl(db).replaceAll({'com.chrome'});

    final setup = await _createBloc(
      db: db,
      apps: const [
        LauncherApp(packageName: 'com.chrome', displayName: 'Chrome'),
      ],
    );

    setup.bloc.add(const HomeEvent.started());
    await setup.bloc.stream.firstWhere(
      (state) => state.mapOrNull(loaded: (_) => true) ?? false,
    );

    setup.bloc.add(const HomeEvent.appTapped(0));
    await expectLater(
      setup.bloc.stream,
      emits(
        isA<HomeState>().having(
          (state) => state.mapOrNull(
            loaded: (loaded) => loaded.pendingRestrictedLaunchPackageName,
          ),
          'pending package',
          'com.chrome',
        ),
      ),
    );
    expect(setup.installedAppsPort.lastOpenedPackageName, isNull);

    setup.bloc.add(const HomeEvent.restrictedLaunchConfirmed());
    await Future<void>.delayed(Duration.zero);
    expect(setup.installedAppsPort.lastOpenedPackageName, 'com.chrome');

    await setup.bloc.close();
  });
}
