import 'package:bedrock_launcher/db/daos/appearance_preferences_dao.dart';
import 'package:bedrock_launcher/domain/entities/appearance_preferences.dart';
import 'package:bedrock_launcher/domain/entities/launcher_text_color.dart';
import 'package:bedrock_launcher/domain/repositories/appearance_preferences_repository.dart';
import 'package:sqflite/sqflite.dart';

class AppearancePreferencesRepositoryImpl
    implements AppearancePreferencesRepository {
  AppearancePreferencesRepositoryImpl(Database database)
      : _dao = AppearancePreferencesDao(database);

  final AppearancePreferencesDao _dao;

  @override
  Future<AppearancePreferences> get() => _dao.get();

  @override
  Future<void> setThemeColor(int themeColorArgb) {
    return _dao.setThemeColor(themeColorArgb);
  }

  @override
  Future<void> setTextColor(LauncherTextColor textColor) {
    return _dao.setTextColor(textColor);
  }

  @override
  Future<void> save(AppearancePreferences preferences) {
    return _dao.save(preferences);
  }
}
