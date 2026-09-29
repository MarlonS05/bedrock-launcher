import 'package:bedrock_launcher/domain/entities/appearance_preferences.dart';
import 'package:bedrock_launcher/domain/entities/launcher_text_color.dart';

abstract class AppearancePreferencesRepository {
  Future<AppearancePreferences> get();

  Future<void> setThemeColor(int themeColorArgb);

  Future<void> setTextColor(LauncherTextColor textColor);

  Future<void> save(AppearancePreferences preferences);
}
