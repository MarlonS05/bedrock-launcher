import 'package:bedrock_launcher/domain/repositories/installed_apps_repository.dart';
import 'package:bedrock_launcher/domain/services/installed_apps_port.dart';

class UninstallAppUseCase {
  const UninstallAppUseCase(
    this._installedAppsPort,
    this._installedAppsRepository,
  );

  final InstalledAppsPort _installedAppsPort;
  final InstalledAppsRepository _installedAppsRepository;

  Future<void> call(String packageName) async {
    await _installedAppsPort.uninstallApp(packageName);
    _installedAppsRepository.invalidate();
  }
}
