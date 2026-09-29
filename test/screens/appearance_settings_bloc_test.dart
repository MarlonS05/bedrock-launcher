import 'package:bedrock_launcher/db/app_database.dart';
import 'package:bedrock_launcher/domain/entities/appearance_preferences.dart';
import 'package:bedrock_launcher/domain/entities/installed_font.dart';
import 'package:bedrock_launcher/domain/entities/launcher_app_font.dart';
import 'package:bedrock_launcher/domain/entities/launcher_text_color.dart';
import 'package:bedrock_launcher/domain/services/installed_fonts_port.dart';
import 'package:bedrock_launcher/domain/use_cases/get_appearance_preferences_use_case.dart';
import 'package:bedrock_launcher/domain/use_cases/set_appearance_preferences_use_case.dart';
import 'package:bedrock_launcher/repo/appearance_preferences_repository_impl.dart';
import 'package:bedrock_launcher/router/app_router.dart';
import 'package:bedrock_launcher/screens/settings/appearance/appearance_settings_bloc.dart';
import 'package:bedrock_launcher/screens/settings/appearance/appearance_settings_event.dart';
import 'package:bedrock_launcher/screens/settings/appearance/appearance_settings_state.dart';
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

class _FakeInstalledFontsPort implements InstalledFontsPort {
  final loadedFamilyIds = <String>[];

  @override
  Future<List<InstalledFont>> listFonts() async => const [
        InstalledFont(
          familyId: 'Roboto',
          label: 'Roboto',
          path: '/system/fonts/Roboto-Regular.ttf',
        ),
      ];

  @override
  Future<void> loadFont(String familyId) async {
    loadedFamilyIds.add(familyId);
  }
}

void main() {
  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  group('AppearanceSettingsBloc', () {
    late _FakeAppRouter appRouter;
    late AppearanceSettingsBloc bloc;
    late AppearancePreferencesRepositoryImpl repository;
    late _FakeInstalledFontsPort installedFontsPort;

    setUp(() async {
      appRouter = _FakeAppRouter();
      installedFontsPort = _FakeInstalledFontsPort();
      final db = await openInMemoryAppDatabase(
        name: 'appearance_bloc_${DateTime.now().microsecondsSinceEpoch}',
      );
      addTearDown(() async {
        await bloc.close();
        await db.close();
      });

      repository = AppearancePreferencesRepositoryImpl(db);
      bloc = AppearanceSettingsBloc(
        appRouter: appRouter,
        getAppearancePreferencesUseCase:
            GetAppearancePreferencesUseCase(repository),
        setAppearancePreferencesUseCase:
            SetAppearancePreferencesUseCase(repository),
        installedFontsPort: installedFontsPort,
      );
    });

    Future<void> pumpToLoaded() async {
      bloc.add(const AppearanceSettingsEvent.started());
      await bloc.stream.firstWhere(
        (state) => state.maybeMap(loaded: (_) => true, orElse: () => false),
      );
    }

    test('started loads available device fonts', () async {
      await pumpToLoaded();

      final loaded = bloc.state.mapOrNull(loaded: (value) => value);
      expect(
        loaded?.availableFonts,
        [
          LauncherAppFont.system,
          const LauncherAppFont('Roboto'),
        ],
      );
      expect(installedFontsPort.loadedFamilyIds, contains('system'));
    });

    test('back without changes pops immediately', () async {
      await pumpToLoaded();

      bloc.add(const AppearanceSettingsEvent.backTapped());
      await bloc.stream.firstWhere(
        (state) => state.maybeMap(closing: (_) => true, orElse: () => false),
      );

      expect(appRouter.popCount, 1);
    });

    test('back with unsaved changes pops without saving', () async {
      await pumpToLoaded();

      bloc.add(
        const AppearanceSettingsEvent.themeColorChanged(0xFF112233),
      );
      await bloc.stream.firstWhere((state) => state.hasUnsavedChanges);

      bloc.add(const AppearanceSettingsEvent.backTapped());
      await bloc.stream.firstWhere(
        (state) => state.maybeMap(closing: (_) => true, orElse: () => false),
      );

      expect(appRouter.popCount, 1);

      final prefs = await repository.get();
      expect(prefs.themeColorArgb, AppearancePreferences.defaultThemeColorArgb);
    });

    test('save persists draft and clears unsaved changes', () async {
      await pumpToLoaded();

      bloc.add(
        const AppearanceSettingsEvent.textColorChanged(
          LauncherTextColor.white,
        ),
      );
      await bloc.stream.firstWhere((state) => state.hasUnsavedChanges);

      bloc.add(const AppearanceSettingsEvent.saveTapped());
      await bloc.stream.firstWhere(
        (state) => state.maybeMap(
          loaded: (loaded) => !loaded.isSaving && !state.hasUnsavedChanges,
          orElse: () => false,
        ),
      );

      final loaded = bloc.state.mapOrNull(loaded: (value) => value);
      expect(loaded?.savedTextColor, LauncherTextColor.white);
      expect(loaded?.draftTextColor, LauncherTextColor.white);
      expect(bloc.state.hasUnsavedChanges, isFalse);
    });

    test('tileSeparatorsChanged updates draft and save persists', () async {
      await pumpToLoaded();

      bloc.add(const AppearanceSettingsEvent.tileSeparatorsChanged(false));
      await bloc.stream.firstWhere((state) => state.hasUnsavedChanges);

      bloc.add(const AppearanceSettingsEvent.saveTapped());
      await bloc.stream.firstWhere(
        (state) => state.maybeMap(
          loaded: (loaded) => !loaded.isSaving && !state.hasUnsavedChanges,
          orElse: () => false,
        ),
      );

      final prefs = await repository.get();
      expect(prefs.showTileSeparators, isFalse);
    });

    test('appFontChanged updates draft and save persists', () async {
      await pumpToLoaded();

      const deviceFont = LauncherAppFont('Roboto');
      bloc.add(const AppearanceSettingsEvent.appFontChanged(deviceFont));
      await bloc.stream.firstWhere((state) => state.hasUnsavedChanges);

      bloc.add(const AppearanceSettingsEvent.saveTapped());
      await bloc.stream.firstWhere(
        (state) => state.maybeMap(
          loaded: (loaded) => !loaded.isSaving && !state.hasUnsavedChanges,
          orElse: () => false,
        ),
      );

      final prefs = await repository.get();
      expect(prefs.appFont, deviceFont);
      expect(installedFontsPort.loadedFamilyIds, contains('Roboto'));
    });
  });
}
