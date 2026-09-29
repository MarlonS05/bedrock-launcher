import 'package:bedrock_launcher/domain/entities/appearance_preferences.dart';
import 'package:bedrock_launcher/domain/repositories/appearance_preferences_repository.dart';

class GetAppearancePreferencesUseCase {
  const GetAppearancePreferencesUseCase(this._repository);

  final AppearancePreferencesRepository _repository;

  Future<AppearancePreferences> call() => _repository.get();
}
