import 'package:bedrock_launcher/domain/services/launcher_settings_port.dart';

class OpenDefaultLauncherSettingsUseCase {
  const OpenDefaultLauncherSettingsUseCase(this._launcherSettingsPort);

  final LauncherSettingsPort _launcherSettingsPort;

  Future<void> call() => _launcherSettingsPort.openDefaultLauncherSettings();
}
