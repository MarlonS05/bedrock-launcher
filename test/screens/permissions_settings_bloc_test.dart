import 'package:bedrock_launcher/domain/services/launcher_settings_port.dart';
import 'package:bedrock_launcher/domain/use_cases/open_default_launcher_settings_use_case.dart';
import 'package:bedrock_launcher/router/app_router.dart';
import 'package:bedrock_launcher/screens/settings/permissions/permissions_settings_bloc.dart';
import 'package:bedrock_launcher/screens/settings/permissions/permissions_settings_event.dart';
import 'package:bedrock_launcher/screens/settings/permissions/permissions_settings_state.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakeAppRouter implements AppRouter {
  var popCount = 0;

  @override
  void goHome() {}

  @override
  Future<void> goAllApps() async {}

  @override
  Future<void> goSettings() async {}

  @override
  void goSettingsAppearance() {}

  @override
  void goSettingsPermissions() {}

  @override
  void goSettingsFavorites() {}

  @override
  void goSettingsPreferredApps() {}

  @override
  void goSettingsRestrictedApps() {}

  @override
  void pop() => popCount++;
}

class _FakeLauncherSettingsPort implements LauncherSettingsPort {
  var openCount = 0;
  Exception? error;

  @override
  Future<void> openDefaultLauncherSettings() async {
    openCount++;
    if (error != null) {
      throw error!;
    }
  }
}

void main() {
  group('PermissionsSettingsBloc', () {
    late _FakeAppRouter appRouter;
    late _FakeLauncherSettingsPort launcherSettingsPort;
    late PermissionsSettingsBloc bloc;

    setUp(() {
      appRouter = _FakeAppRouter();
      launcherSettingsPort = _FakeLauncherSettingsPort();
      bloc = PermissionsSettingsBloc(
        appRouter: appRouter,
        openDefaultLauncherSettingsUseCase: OpenDefaultLauncherSettingsUseCase(
          launcherSettingsPort,
        ),
      );
    });

    tearDown(() async {
      await bloc.close();
    });

    test('backTapped pops immediately', () async {
      bloc.add(const PermissionsSettingsEvent.backTapped());
      await bloc.stream.firstWhere(
        (state) => state.maybeMap(closing: (_) => true, orElse: () => false),
      );

      expect(appRouter.popCount, 1);
    });

    test('openDefaultLauncherTapped calls port', () async {
      bloc.add(const PermissionsSettingsEvent.openDefaultLauncherTapped());
      await bloc.stream.firstWhere(
        (state) => state.maybeMap(
          loaded: (value) => !value.isOpening,
          orElse: () => false,
        ),
      );

      expect(launcherSettingsPort.openCount, 1);
      expect(
        bloc.state,
        const PermissionsSettingsState.loaded(actionErrorMessage: null),
      );
    });

    test('openDefaultLauncherTapped surfaces port failure', () async {
      launcherSettingsPort.error = Exception('Settings unavailable');

      bloc.add(const PermissionsSettingsEvent.openDefaultLauncherTapped());
      await bloc.stream.firstWhere(
        (state) => state.maybeMap(
          loaded: (value) => value.actionErrorMessage != null,
          orElse: () => false,
        ),
      );

      expect(launcherSettingsPort.openCount, 1);
      expect(
        bloc.state,
        const PermissionsSettingsState.loaded(
          actionErrorMessage: 'Exception: Settings unavailable',
        ),
      );
    });
  });
}
