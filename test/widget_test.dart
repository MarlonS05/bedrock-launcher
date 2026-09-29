import 'package:bedrock_launcher/db/app_database.dart';
import 'package:bedrock_launcher/di/di.dart';
import 'package:bedrock_launcher/domain/entities/launcher_app.dart';
import 'package:bedrock_launcher/domain/services/battery_port.dart';
import 'package:bedrock_launcher/domain/services/installed_apps_port.dart';
import 'package:bedrock_launcher/domain/use_cases/list_installed_apps_use_case.dart';
import 'package:bedrock_launcher/main.dart';
import 'package:bedrock_launcher/repo/favorite_app_repository_impl.dart';
import 'package:bedrock_launcher/repo/installed_apps_repository_impl.dart';
import 'package:bedrock_launcher/domain/repositories/installed_apps_repository.dart';
import 'package:bedrock_launcher/screens/components/launcher/launcher_analog_clock.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class _FakeInstalledAppsPort implements InstalledAppsPort {
  _FakeInstalledAppsPort(this._apps);

  final List<LauncherApp> _apps;

  @override
  Future<List<LauncherApp>> getInstalledApps() async => _apps;

  @override
  Future<void> openApp(String packageName) async {}

  @override
  Future<void> openAppSettings(String packageName) async {}

  @override
  Future<void> uninstallApp(String packageName) async {}
}

class _FakeBatteryPort implements BatteryPort {
  @override
  Future<int> getBatteryLevel() async => 75;
}

void main() {
  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  setUp(() async {
    await getIt.reset();
    final db = await openInMemoryAppDatabase(
      name: 'widget_test_${DateTime.now().microsecondsSinceEpoch}',
    );
    await configureDependencies(openDatabase: () async => db);

    final favoriteRepository = FavoriteAppRepositoryImpl(db);
    await favoriteRepository.add('com.camera');

    getIt.unregister<InstalledAppsPort>();
    getIt.registerLazySingleton<InstalledAppsPort>(
      () => _FakeInstalledAppsPort(const [
        LauncherApp(packageName: 'com.camera', displayName: 'Camera'),
      ]),
    );
    getIt.unregister<InstalledAppsRepository>();
    getIt.registerLazySingleton<InstalledAppsRepository>(
      () => InstalledAppsRepositoryImpl(getIt()),
    );
    getIt.unregister<ListInstalledAppsUseCase>();
    getIt.registerLazySingleton(() => ListInstalledAppsUseCase(getIt()));
    getIt.unregister<BatteryPort>();
    getIt.registerLazySingleton<BatteryPort>(_FakeBatteryPort.new);
  });

  testWidgets('App loads home view', (WidgetTester tester) async {
    await tester.pumpWidget(const BedrockLauncherApp());
    await tester.pump();
    await tester.runAsync(
      () => Future<void>.delayed(const Duration(milliseconds: 200)),
    );
    await tester.pump();

    expect(find.text('Camera'), findsOneWidget);
    expect(find.byType(LauncherAnalogClock), findsOneWidget);
  });
}
