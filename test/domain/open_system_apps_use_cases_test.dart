import 'package:bedrock_launcher/domain/entities/launcher_app.dart';
import 'package:bedrock_launcher/domain/entities/preferred_apps_preferences.dart';
import 'package:bedrock_launcher/domain/repositories/preferred_apps_preferences_repository.dart';
import 'package:bedrock_launcher/domain/services/installed_apps_port.dart';
import 'package:bedrock_launcher/domain/services/system_apps_port.dart';
import 'package:bedrock_launcher/domain/use_cases/get_preferred_apps_preferences_use_case.dart';
import 'package:bedrock_launcher/domain/use_cases/launch_app_use_case.dart';
import 'package:bedrock_launcher/domain/use_cases/open_camera_use_case.dart';
import 'package:bedrock_launcher/domain/use_cases/open_clock_use_case.dart';
import 'package:bedrock_launcher/domain/use_cases/open_dialer_use_case.dart';
import 'package:bedrock_launcher/domain/use_cases/open_gallery_use_case.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakePreferredAppsPreferencesRepository
    implements PreferredAppsPreferencesRepository {
  PreferredAppsPreferences _preferences = PreferredAppsPreferences.defaults;

  void setPreferences(PreferredAppsPreferences preferences) {
    _preferences = preferences;
  }

  @override
  Future<PreferredAppsPreferences> get() async => _preferences;

  @override
  Future<void> save(PreferredAppsPreferences preferences) async {
    _preferences = preferences;
  }
}

class _FakeInstalledAppsPort implements InstalledAppsPort {
  String? lastOpenedPackageName;
  var shouldFailOpen = false;

  @override
  Future<List<LauncherApp>> getInstalledApps() async => const [];

  @override
  Future<void> openApp(String packageName) async {
    if (shouldFailOpen) {
      throw Exception('open failed');
    }
    lastOpenedPackageName = packageName;
  }

  @override
  Future<void> openAppSettings(String packageName) async {}

  @override
  Future<void> uninstallApp(String packageName) async {}
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

void main() {
  late _FakePreferredAppsPreferencesRepository preferencesRepository;
  late _FakeInstalledAppsPort installedAppsPort;
  late _FakeSystemAppsPort systemAppsPort;
  late GetPreferredAppsPreferencesUseCase getPreferredAppsPreferencesUseCase;
  late LaunchAppUseCase launchAppUseCase;

  setUp(() {
    preferencesRepository = _FakePreferredAppsPreferencesRepository();
    installedAppsPort = _FakeInstalledAppsPort();
    systemAppsPort = _FakeSystemAppsPort();
    getPreferredAppsPreferencesUseCase = GetPreferredAppsPreferencesUseCase(
      preferencesRepository,
    );
    launchAppUseCase = LaunchAppUseCase(installedAppsPort);
  });

  group('OpenDialerUseCase', () {
    late OpenDialerUseCase useCase;

    setUp(() {
      useCase = OpenDialerUseCase(
        systemAppsPort,
        getPreferredAppsPreferencesUseCase,
        launchAppUseCase,
      );
    });

    test('opens system dialer when no preferred phone is set', () async {
      await useCase();

      expect(systemAppsPort.dialerOpenCount, 1);
      expect(installedAppsPort.lastOpenedPackageName, isNull);
    });

    test('launches preferred phone package when set', () async {
      preferencesRepository.setPreferences(
        const PreferredAppsPreferences(phonePackageName: 'com.phone.app'),
      );

      await useCase();

      expect(installedAppsPort.lastOpenedPackageName, 'com.phone.app');
      expect(systemAppsPort.dialerOpenCount, 0);
    });

    test('falls back to system dialer when preferred launch fails', () async {
      preferencesRepository.setPreferences(
        const PreferredAppsPreferences(phonePackageName: 'com.phone.app'),
      );
      installedAppsPort.shouldFailOpen = true;

      await useCase();

      expect(systemAppsPort.dialerOpenCount, 1);
    });
  });

  group('OpenCameraUseCase', () {
    late OpenCameraUseCase useCase;

    setUp(() {
      useCase = OpenCameraUseCase(
        systemAppsPort,
        getPreferredAppsPreferencesUseCase,
        launchAppUseCase,
      );
    });

    test('opens system camera when no preferred camera is set', () async {
      await useCase();

      expect(systemAppsPort.cameraOpenCount, 1);
      expect(installedAppsPort.lastOpenedPackageName, isNull);
    });

    test('launches preferred camera package when set', () async {
      preferencesRepository.setPreferences(
        const PreferredAppsPreferences(cameraPackageName: 'com.camera.app'),
      );

      await useCase();

      expect(installedAppsPort.lastOpenedPackageName, 'com.camera.app');
      expect(systemAppsPort.cameraOpenCount, 0);
    });

    test('falls back to system camera when preferred launch fails', () async {
      preferencesRepository.setPreferences(
        const PreferredAppsPreferences(cameraPackageName: 'com.camera.app'),
      );
      installedAppsPort.shouldFailOpen = true;

      await useCase();

      expect(systemAppsPort.cameraOpenCount, 1);
    });
  });

  group('OpenGalleryUseCase', () {
    late OpenGalleryUseCase useCase;

    setUp(() {
      useCase = OpenGalleryUseCase(
        systemAppsPort,
        getPreferredAppsPreferencesUseCase,
        launchAppUseCase,
      );
    });

    test('opens system gallery when no preferred gallery is set', () async {
      await useCase();

      expect(systemAppsPort.galleryOpenCount, 1);
      expect(installedAppsPort.lastOpenedPackageName, isNull);
    });

    test('launches preferred gallery package when set', () async {
      preferencesRepository.setPreferences(
        const PreferredAppsPreferences(galleryPackageName: 'com.gallery.app'),
      );

      await useCase();

      expect(installedAppsPort.lastOpenedPackageName, 'com.gallery.app');
      expect(systemAppsPort.galleryOpenCount, 0);
    });

    test('falls back to system gallery when preferred launch fails', () async {
      preferencesRepository.setPreferences(
        const PreferredAppsPreferences(galleryPackageName: 'com.gallery.app'),
      );
      installedAppsPort.shouldFailOpen = true;

      await useCase();

      expect(systemAppsPort.galleryOpenCount, 1);
    });
  });

  group('OpenClockUseCase', () {
    late OpenClockUseCase useCase;

    setUp(() {
      useCase = OpenClockUseCase(
        systemAppsPort,
        getPreferredAppsPreferencesUseCase,
        launchAppUseCase,
      );
    });

    test('opens system clock when no preferred clock is set', () async {
      await useCase();

      expect(systemAppsPort.clockOpenCount, 1);
      expect(installedAppsPort.lastOpenedPackageName, isNull);
    });

    test('launches preferred clock package when set', () async {
      preferencesRepository.setPreferences(
        const PreferredAppsPreferences(clockPackageName: 'com.clock.app'),
      );

      await useCase();

      expect(installedAppsPort.lastOpenedPackageName, 'com.clock.app');
      expect(systemAppsPort.clockOpenCount, 0);
    });

    test('falls back to system clock when preferred launch fails', () async {
      preferencesRepository.setPreferences(
        const PreferredAppsPreferences(clockPackageName: 'com.clock.app'),
      );
      installedAppsPort.shouldFailOpen = true;

      await useCase();

      expect(systemAppsPort.clockOpenCount, 1);
    });
  });
}
