import 'package:bedrock_launcher/domain/entities/launcher_app.dart';
import 'package:bedrock_launcher/domain/entities/launcher_text_color.dart';
import 'package:bedrock_launcher/domain/entities/preferred_apps_preferences.dart';
import 'package:bedrock_launcher/domain/services/installed_fonts_port.dart';
import 'package:bedrock_launcher/domain/use_cases/get_appearance_preferences_use_case.dart';
import 'package:bedrock_launcher/domain/use_cases/get_battery_level_use_case.dart';
import 'package:bedrock_launcher/domain/use_cases/get_preferred_apps_preferences_use_case.dart';
import 'package:bedrock_launcher/domain/use_cases/launch_app_use_case.dart';
import 'package:bedrock_launcher/domain/use_cases/load_launcher_apps_use_case.dart';
import 'package:bedrock_launcher/domain/use_cases/open_camera_use_case.dart';
import 'package:bedrock_launcher/domain/use_cases/open_clock_use_case.dart';
import 'package:bedrock_launcher/domain/use_cases/open_gallery_use_case.dart';
import 'package:bedrock_launcher/domain/use_cases/open_default_browser_use_case.dart';
import 'package:bedrock_launcher/domain/use_cases/open_dialer_use_case.dart';
import 'package:bedrock_launcher/router/app_router.dart';
import 'package:bedrock_launcher/screens/home/home_event.dart';
import 'package:bedrock_launcher/screens/home/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({
    required this.appRouter,
    required this.getAppearancePreferencesUseCase,
    required this.getPreferredAppsPreferencesUseCase,
    required this.loadLauncherAppsUseCase,
    required this.getBatteryLevelUseCase,
    required this.launchAppUseCase,
    required this.openDefaultBrowserUseCase,
    required this.openDialerUseCase,
    required this.openCameraUseCase,
    required this.openGalleryUseCase,
    required this.openClockUseCase,
    required this.installedFontsPort,
  }) : super(const HomeState.loading()) {
    on<HomeEvent>(_onEvent);
  }

  final AppRouter appRouter;
  final GetAppearancePreferencesUseCase getAppearancePreferencesUseCase;
  final GetPreferredAppsPreferencesUseCase getPreferredAppsPreferencesUseCase;
  final LoadLauncherAppsUseCase loadLauncherAppsUseCase;
  final GetBatteryLevelUseCase getBatteryLevelUseCase;
  final LaunchAppUseCase launchAppUseCase;
  final OpenDefaultBrowserUseCase openDefaultBrowserUseCase;
  final OpenDialerUseCase openDialerUseCase;
  final OpenCameraUseCase openCameraUseCase;
  final OpenGalleryUseCase openGalleryUseCase;
  final OpenClockUseCase openClockUseCase;
  final InstalledFontsPort installedFontsPort;

  Future<void> _onEvent(HomeEvent event, Emitter<HomeState> emit) async {
    await event.when(
      started: () => _loadApps(emit),
      retryTapped: () => _loadApps(emit),
      appearancePreferencesChanged: () => _refreshLoaded(emit),
      appTapped: (index) async {
        final current = state.mapOrNull(loaded: (value) => value);
        if (current == null || index < 0 || index >= current.apps.length) {
          return;
        }
        final app = current.apps[index];
        if (app.isRestricted) {
          emit(
            current.copyWith(
              pendingRestrictedLaunchPackageName: app.packageName,
            ),
          );
          return;
        }
        await launchAppUseCase(app.packageName);
      },
      browserSwipeUpDetected: () async {
        await openDefaultBrowserUseCase();
      },
      allAppsTapped: () async {
        await appRouter.goAllApps();
        add(const HomeEvent.appearancePreferencesChanged());
      },
      settingsTapped: () async {
        await appRouter.goSettings();
        add(const HomeEvent.appearancePreferencesChanged());
      },
      phoneTapped: () async {
        await _openCornerOrChallenge(
          emit,
          preferredPackage: (prefs) => prefs.phonePackageName,
          openSystemOrPreferred: () => openDialerUseCase(),
        );
      },
      cameraTapped: () async {
        await _openCornerOrChallenge(
          emit,
          preferredPackage: (prefs) => prefs.cameraPackageName,
          openSystemOrPreferred: () => openCameraUseCase(),
        );
      },
      cameraLongPressed: () async {
        await _openCornerOrChallenge(
          emit,
          preferredPackage: (prefs) => prefs.galleryPackageName,
          openSystemOrPreferred: () => openGalleryUseCase(),
        );
      },
      clockTapped: () async {
        await _openCornerOrChallenge(
          emit,
          preferredPackage: (prefs) => prefs.clockPackageName,
          openSystemOrPreferred: () => openClockUseCase(),
        );
      },
      batteryRefreshRequested: () => _refreshBattery(emit),
      restrictedLaunchConfirmed: () async {
        final current = state.mapOrNull(loaded: (value) => value);
        final packageName = current?.pendingRestrictedLaunchPackageName;
        if (current == null || packageName == null) {
          return;
        }
        emit(current.copyWith(pendingRestrictedLaunchPackageName: null));
        await launchAppUseCase(packageName);
      },
      restrictedLaunchCancelled: () async {
        final current = state.mapOrNull(loaded: (value) => value);
        if (current == null) {
          return;
        }
        emit(current.copyWith(pendingRestrictedLaunchPackageName: null));
      },
      browserDoubleTapped: () async {
        final current = state.mapOrNull(loaded: (value) => value);
        if (current == null || current.pendingMathPractice) {
          return;
        }
        emit(current.copyWith(pendingMathPractice: true));
      },
      mathPracticeDismissed: () async {
        final current = state.mapOrNull(loaded: (value) => value);
        if (current == null) {
          return;
        }
        emit(current.copyWith(pendingMathPractice: false));
      },
    );
  }

  Future<void> _openCornerOrChallenge(
    Emitter<HomeState> emit, {
    required String? Function(PreferredAppsPreferences prefs) preferredPackage,
    required Future<void> Function() openSystemOrPreferred,
  }) async {
    final current = state.mapOrNull(loaded: (value) => value);
    if (current == null) {
      await openSystemOrPreferred();
      return;
    }

    final prefs = await getPreferredAppsPreferencesUseCase();
    final packageName = preferredPackage(prefs);
    if (packageName != null &&
        current.restrictedPackageNames.contains(packageName)) {
      emit(
        current.copyWith(pendingRestrictedLaunchPackageName: packageName),
      );
      return;
    }
    await openSystemOrPreferred();
  }

  Future<int?> _readBatteryLevel() async {
    try {
      return await getBatteryLevelUseCase();
    } catch (_) {
      return null;
    }
  }

  Future<void> _refreshBattery(Emitter<HomeState> emit) async {
    final current = state.mapOrNull(loaded: (value) => value);
    if (current == null) {
      return;
    }

    final batteryLevel = await _readBatteryLevel();
    emit(current.copyWith(batteryLevel: batteryLevel));
  }

  Future<void> _loadApps(Emitter<HomeState> emit) async {
    emit(const HomeState.loading());
    try {
      final appearance = await getAppearancePreferencesUseCase();
      await installedFontsPort.loadFont(appearance.appFont.familyId);
      final snapshotData = await _resolveSnapshot();
      final batteryLevel = await _readBatteryLevel();
      emit(
        HomeState.loaded(
          apps: snapshotData.apps,
          themeColorArgb: appearance.themeColorArgb,
          useWhiteText: appearance.textColor == LauncherTextColor.white,
          showTileSeparators: appearance.showTileSeparators,
          appFont: appearance.appFont,
          restrictedPackageNames: snapshotData.restrictedPackageNames,
          batteryLevel: batteryLevel,
        ),
      );
    } catch (error) {
      emit(HomeState.error(message: error.toString()));
    }
  }

  Future<void> _refreshLoaded(Emitter<HomeState> emit) async {
    final current = state.mapOrNull(loaded: (value) => value);
    if (current == null) {
      return;
    }

    try {
      final appearance = await getAppearancePreferencesUseCase();
      await installedFontsPort.loadFont(appearance.appFont.familyId);
      final snapshotData = await _resolveSnapshot();
      final batteryLevel = await _readBatteryLevel();
      emit(
        current.copyWith(
          apps: snapshotData.apps,
          themeColorArgb: appearance.themeColorArgb,
          useWhiteText: appearance.textColor == LauncherTextColor.white,
          showTileSeparators: appearance.showTileSeparators,
          appFont: appearance.appFont,
          restrictedPackageNames: snapshotData.restrictedPackageNames,
          batteryLevel: batteryLevel,
          pendingRestrictedLaunchPackageName: null,
        ),
      );
    } catch (error) {
      emit(HomeState.error(message: error.toString()));
    }
  }

  Future<({List<LauncherApp> apps, Set<String> restrictedPackageNames})>
      _resolveSnapshot() async {
    final snapshot = await loadLauncherAppsUseCase();
    return (
      apps: snapshot.favoriteApps,
      restrictedPackageNames: snapshot.restrictedPackageNames,
    );
  }
}
