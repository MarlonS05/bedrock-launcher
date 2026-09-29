import 'package:bedrock_launcher/domain/entities/launcher_text_color.dart';
import 'package:bedrock_launcher/domain/repositories/appearance_preferences_repository.dart';

class SetTextColorUseCase {
  const SetTextColorUseCase(this._repository);

  final AppearancePreferencesRepository _repository;

  Future<void> call(LauncherTextColor textColor) {
    return _repository.setTextColor(textColor);
  }
}
