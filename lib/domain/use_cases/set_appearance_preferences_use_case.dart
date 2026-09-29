import 'package:bedrock_launcher/domain/entities/appearance_preferences.dart';
import 'package:bedrock_launcher/domain/repositories/appearance_preferences_repository.dart';

class SetAppearancePreferencesUseCase {
  const SetAppearancePreferencesUseCase(this._repository);

  final AppearancePreferencesRepository _repository;

  Future<void> call(AppearancePreferences preferences) {
    return _repository.save(preferences);
  }
}
