import 'package:bedrock_launcher/domain/services/installed_apps_port.dart';

class OpenAppSettingsUseCase {
  const OpenAppSettingsUseCase(this._installedAppsPort);

  final InstalledAppsPort _installedAppsPort;

  Future<void> call(String packageName) =>
      _installedAppsPort.openAppSettings(packageName);
}
