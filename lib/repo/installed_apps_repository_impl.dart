import 'package:bedrock_launcher/domain/entities/launcher_app.dart';
import 'package:bedrock_launcher/domain/repositories/installed_apps_repository.dart';
import 'package:bedrock_launcher/domain/services/installed_apps_port.dart';

class InstalledAppsRepositoryImpl implements InstalledAppsRepository {
  InstalledAppsRepositoryImpl(this._installedAppsPort);

  final InstalledAppsPort _installedAppsPort;

  List<LauncherApp>? _cachedApps;
  Future<List<LauncherApp>>? _inFlight;

  @override
  List<LauncherApp>? get cached => _cachedApps;

  @override
  Future<List<LauncherApp>> getInstalledApps({bool forceRefresh = false}) async {
    if (!forceRefresh && _cachedApps != null) {
      return _cachedApps!;
    }

    if (!forceRefresh && _inFlight != null) {
      return _inFlight!;
    }

    final fetch = _fetchAndCache();
    if (!forceRefresh) {
      _inFlight = fetch;
    }

    try {
      return await fetch;
    } finally {
      if (!forceRefresh && identical(_inFlight, fetch)) {
        _inFlight = null;
      }
    }
  }

  @override
  void invalidate() {
    _cachedApps = null;
    _inFlight = null;
  }

  Future<List<LauncherApp>> _fetchAndCache() async {
    final apps = await _installedAppsPort.getInstalledApps();
    _cachedApps = apps;
    return apps;
  }
}
