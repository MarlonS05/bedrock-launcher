import 'package:bedrock_launcher/domain/entities/preferred_apps_preferences.dart';

abstract class PreferredAppsPreferencesRepository {
  Future<PreferredAppsPreferences> get();

  Future<void> save(PreferredAppsPreferences preferences);
}
