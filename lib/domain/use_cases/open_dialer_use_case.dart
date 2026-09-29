import 'package:bedrock_launcher/domain/services/system_apps_port.dart';
import 'package:bedrock_launcher/domain/use_cases/get_preferred_apps_preferences_use_case.dart';
import 'package:bedrock_launcher/domain/use_cases/launch_app_use_case.dart';

class OpenDialerUseCase {
  const OpenDialerUseCase(
    this._systemAppsPort,
    this._getPreferredAppsPreferencesUseCase,
    this._launchAppUseCase,
  );

  final SystemAppsPort _systemAppsPort;
  final GetPreferredAppsPreferencesUseCase _getPreferredAppsPreferencesUseCase;
  final LaunchAppUseCase _launchAppUseCase;

  Future<void> call() async {
    final prefs = await _getPreferredAppsPreferencesUseCase();
    final packageName = prefs.phonePackageName;
    if (packageName != null) {
      try {
        await _launchAppUseCase(packageName);
        return;
      } catch (_) {
        // Preferred app missing / not launchable → system dialer.
      }
    }
    await _systemAppsPort.openDialer();
  }
}
