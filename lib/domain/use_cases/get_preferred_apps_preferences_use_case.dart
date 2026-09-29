import 'package:bedrock_launcher/domain/entities/preferred_apps_preferences.dart';
import 'package:bedrock_launcher/domain/repositories/preferred_apps_preferences_repository.dart';

class GetPreferredAppsPreferencesUseCase {
  const GetPreferredAppsPreferencesUseCase(this._repository);

  final PreferredAppsPreferencesRepository _repository;

  Future<PreferredAppsPreferences> call() => _repository.get();
}
