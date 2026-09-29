import 'package:bedrock_launcher/domain/entities/preferred_apps_preferences.dart';
import 'package:bedrock_launcher/domain/repositories/preferred_apps_preferences_repository.dart';

class SetPreferredAppsPreferencesUseCase {
  const SetPreferredAppsPreferencesUseCase(this._repository);

  final PreferredAppsPreferencesRepository _repository;

  Future<void> call(PreferredAppsPreferences preferences) {
    return _repository.save(preferences);
  }
}
