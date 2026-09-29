import 'package:bedrock_launcher/domain/entities/launcher_app.dart';
import 'package:bedrock_launcher/domain/services/installed_apps_port.dart';
import 'package:device_apps/device_apps.dart';
import 'package:flutter/services.dart';

class AndroidInstalledAppsAdapter implements InstalledAppsPort {
  @override
  Future<List<LauncherApp>> getInstalledApps() async {
    final apps = await DeviceApps.getInstalledApplications(
      onlyAppsWithLaunchIntent: true,
      includeSystemApps: true,
      includeAppIcons: false,
    );

    final launcherApps = apps
        .map(
          (app) => LauncherApp(
            packageName: app.packageName,
            displayName: app.appName,
          ),
        )
        .toList();
    launcherApps.sort(
      (a, b) =>
          a.displayName.toLowerCase().compareTo(b.displayName.toLowerCase()),
    );
    return launcherApps;
  }

  @override
  Future<void> openApp(String packageName) async {
    if (!await DeviceApps.openApp(packageName)) {
      throw PlatformException(
        code: 'OPEN_APP_FAILED',
        message: 'Could not open app: $packageName',
      );
    }
  }

  @override
  Future<void> openAppSettings(String packageName) async {
    if (!await DeviceApps.openAppSettings(packageName)) {
      throw PlatformException(
        code: 'OPEN_APP_SETTINGS_FAILED',
        message: 'Could not open app settings: $packageName',
      );
    }
  }

  @override
  Future<void> uninstallApp(String packageName) async {
    if (!await DeviceApps.uninstallApp(packageName)) {
      throw PlatformException(
        code: 'UNINSTALL_APP_FAILED',
        message: 'Could not start uninstall for: $packageName',
      );
    }
  }
}
