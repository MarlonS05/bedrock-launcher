import 'package:bedrock_launcher/domain/entities/launcher_app.dart';
import 'package:bedrock_launcher/domain/services/installed_apps_port.dart';
import 'package:bedrock_launcher/repo/installed_apps_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakeInstalledAppsPort implements InstalledAppsPort {
  _FakeInstalledAppsPort(this._apps, {this.delay = Duration.zero});

  final List<LauncherApp> _apps;
  final Duration delay;
  var fetchCount = 0;

  @override
  Future<List<LauncherApp>> getInstalledApps() async {
    fetchCount++;
    if (delay > Duration.zero) {
      await Future<void>.delayed(delay);
    }
    return _apps;
  }

  @override
  Future<void> openApp(String packageName) async {}

  @override
  Future<void> openAppSettings(String packageName) async {}

  @override
  Future<void> uninstallApp(String packageName) async {}
}

void main() {
  const apps = [
    LauncherApp(packageName: 'com.chrome', displayName: 'Chrome'),
    LauncherApp(packageName: 'com.camera', displayName: 'Camera'),
  ];

  test('cache hit avoids second port call', () async {
    final port = _FakeInstalledAppsPort(apps);
    final repository = InstalledAppsRepositoryImpl(port);

    final first = await repository.getInstalledApps();
    final second = await repository.getInstalledApps();

    expect(first, apps);
    expect(second, apps);
    expect(port.fetchCount, 1);
    expect(repository.cached, apps);
  });

  test('concurrent calls dedupe to one port call', () async {
    final port = _FakeInstalledAppsPort(apps, delay: const Duration(milliseconds: 50));
    final repository = InstalledAppsRepositoryImpl(port);

    final results = await Future.wait([
      repository.getInstalledApps(),
      repository.getInstalledApps(),
      repository.getInstalledApps(),
    ]);

    expect(results, everyElement(apps));
    expect(port.fetchCount, 1);
  });

  test('forceRefresh bypasses cache', () async {
    final port = _FakeInstalledAppsPort(apps);
    final repository = InstalledAppsRepositoryImpl(port);

    await repository.getInstalledApps();
    await repository.getInstalledApps(forceRefresh: true);

    expect(port.fetchCount, 2);
  });

  test('invalidate clears cache', () async {
    final port = _FakeInstalledAppsPort(apps);
    final repository = InstalledAppsRepositoryImpl(port);

    await repository.getInstalledApps();
    expect(repository.cached, apps);

    repository.invalidate();
    expect(repository.cached, isNull);

    await repository.getInstalledApps();
    expect(port.fetchCount, 2);
  });
}
