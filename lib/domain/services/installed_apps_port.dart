import 'package:bedrock_launcher/domain/entities/launcher_app.dart';

abstract interface class InstalledAppsPort {
  Future<List<LauncherApp>> getInstalledApps();

  Future<void> openApp(String packageName);

  Future<void> openAppSettings(String packageName);

  Future<void> uninstallApp(String packageName);
}
