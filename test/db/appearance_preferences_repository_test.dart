import 'package:bedrock_launcher/db/app_database.dart';
import 'package:bedrock_launcher/domain/entities/appearance_preferences.dart';
import 'package:bedrock_launcher/domain/entities/launcher_app_font.dart';
import 'package:bedrock_launcher/domain/entities/launcher_text_color.dart';
import 'package:bedrock_launcher/repo/appearance_preferences_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  group('AppearancePreferences persistence', () {
    late AppearancePreferencesRepositoryImpl repository;

    setUp(() async {
      final db = await openInMemoryAppDatabase(
        name: 'appearance_test_${DateTime.now().microsecondsSinceEpoch}',
      );
      addTearDown(db.close);
      repository = AppearancePreferencesRepositoryImpl(db);
    });

    test('returns defaults from migration seed row', () async {
      final prefs = await repository.get();

      expect(prefs, AppearancePreferences.defaults);
    });

    test('persists theme color and text color together', () async {
      const newColor = 0xFF336699;

      await repository.save(
        const AppearancePreferences(
          themeColorArgb: newColor,
          textColor: LauncherTextColor.white,
          showTileSeparators: true,
          appFont: LauncherAppFont.system,
        ),
      );
      final prefs = await repository.get();

      expect(prefs.themeColorArgb, newColor);
      expect(prefs.textColor, LauncherTextColor.white);
    });

    test('persists theme color changes', () async {
      const newColor = 0xFF336699;

      await repository.setThemeColor(newColor);
      final prefs = await repository.get();

      expect(prefs.themeColorArgb, newColor);
      expect(prefs.textColor, LauncherTextColor.black);
    });

    test('persists text color changes', () async {
      await repository.setTextColor(LauncherTextColor.white);
      final prefs = await repository.get();

      expect(prefs.textColor, LauncherTextColor.white);
      expect(prefs.themeColorArgb, AppearancePreferences.defaultThemeColorArgb);
    });

    test('persists tile separator visibility', () async {
      await repository.save(
        const AppearancePreferences(
          themeColorArgb: AppearancePreferences.defaultThemeColorArgb,
          textColor: LauncherTextColor.black,
          showTileSeparators: false,
          appFont: LauncherAppFont.system,
        ),
      );
      final prefs = await repository.get();

      expect(prefs.showTileSeparators, isFalse);
      expect(prefs.appFont, LauncherAppFont.system);
    });

    test('persists app font changes', () async {
      const deviceFont = LauncherAppFont('Roboto');
      await repository.save(
        const AppearancePreferences(
          themeColorArgb: AppearancePreferences.defaultThemeColorArgb,
          textColor: LauncherTextColor.black,
          showTileSeparators: true,
          appFont: deviceFont,
        ),
      );
      final prefs = await repository.get();

      expect(prefs.appFont, deviceFont);
    });
  });
}
