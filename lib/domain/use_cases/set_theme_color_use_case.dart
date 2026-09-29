import 'package:bedrock_launcher/domain/repositories/appearance_preferences_repository.dart';

class SetThemeColorUseCase {
  const SetThemeColorUseCase(this._repository);

  final AppearancePreferencesRepository _repository;

  Future<void> call(int themeColorArgb) {
    return _repository.setThemeColor(themeColorArgb);
  }
}
