import 'package:bedrock_launcher/db/daos/preferred_apps_preferences_dao.dart';
import 'package:bedrock_launcher/domain/entities/preferred_apps_preferences.dart';
import 'package:bedrock_launcher/domain/repositories/preferred_apps_preferences_repository.dart';
import 'package:sqflite/sqflite.dart';

class PreferredAppsPreferencesRepositoryImpl
    implements PreferredAppsPreferencesRepository {
  PreferredAppsPreferencesRepositoryImpl(Database database)
      : _dao = PreferredAppsPreferencesDao(database);

  final PreferredAppsPreferencesDao _dao;

  @override
  Future<PreferredAppsPreferences> get() => _dao.get();

  @override
  Future<void> save(PreferredAppsPreferences preferences) {
    return _dao.save(preferences);
  }
}
