import 'package:bedrock_launcher/di/di.dart';
import 'package:bedrock_launcher/router/routes.dart';
import 'package:bedrock_launcher/screens/all_apps/all_apps_bloc.dart';
import 'package:bedrock_launcher/screens/all_apps/all_apps_event.dart';
import 'package:bedrock_launcher/screens/all_apps/all_apps_view.dart';
import 'package:bedrock_launcher/screens/home/home_bloc.dart';
import 'package:bedrock_launcher/screens/home/home_event.dart';
import 'package:bedrock_launcher/screens/home/home_view.dart';
import 'package:bedrock_launcher/screens/settings/appearance/appearance_settings_bloc.dart';
import 'package:bedrock_launcher/screens/settings/appearance/appearance_settings_event.dart';
import 'package:bedrock_launcher/screens/settings/appearance/appearance_settings_view.dart';
import 'package:bedrock_launcher/screens/settings/favorites/favorites_settings_bloc.dart';
import 'package:bedrock_launcher/screens/settings/favorites/favorites_settings_event.dart';
import 'package:bedrock_launcher/screens/settings/favorites/favorites_settings_view.dart';
import 'package:bedrock_launcher/screens/settings/permissions/permissions_settings_bloc.dart';
import 'package:bedrock_launcher/screens/settings/permissions/permissions_settings_event.dart';
import 'package:bedrock_launcher/screens/settings/permissions/permissions_settings_view.dart';
import 'package:bedrock_launcher/screens/settings/preferred_apps/preferred_apps_settings_bloc.dart';
import 'package:bedrock_launcher/screens/settings/preferred_apps/preferred_apps_settings_event.dart';
import 'package:bedrock_launcher/screens/settings/preferred_apps/preferred_apps_settings_view.dart';
import 'package:bedrock_launcher/screens/settings/restricted_apps/restricted_apps_settings_bloc.dart';
import 'package:bedrock_launcher/screens/settings/restricted_apps/restricted_apps_settings_event.dart';
import 'package:bedrock_launcher/screens/settings/restricted_apps/restricted_apps_settings_view.dart';
import 'package:bedrock_launcher/screens/settings/settings_bloc.dart';
import 'package:bedrock_launcher/screens/settings/settings_event.dart';
import 'package:bedrock_launcher/screens/settings/settings_view.dart';
import 'package:bedrock_launcher/theme/win95/win95_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

/// Navigation entrypoint for presentation controllers.
///
/// BLoCs depend on this wrapper instead of importing [go_router] directly.
class AppRouter {
  AppRouter(this._router);

  final GoRouter _router;

  void goHome() => _router.go(Routes.home);

  Future<void> goAllApps() => _router.push(Routes.allApps);

  Future<void> goSettings() => _router.push(Routes.settings);

  void goSettingsAppearance() => _router.push(Routes.settingsAppearance);

  void goSettingsPermissions() => _router.push(Routes.settingsPermissions);

  void goSettingsFavorites() => _router.push(Routes.settingsFavorites);

  void goSettingsPreferredApps() => _router.push(Routes.settingsPreferredApps);

  void goSettingsRestrictedApps() =>
      _router.push(Routes.settingsRestrictedApps);

  void pop() => _router.pop();
}

GoRouter createRouter() {
  return GoRouter(
    initialLocation: Routes.home,
    routes: [
      GoRoute(
        path: Routes.home,
        builder: (context, state) => BlocProvider(
          create: (_) => getIt<HomeBloc>()..add(const HomeEvent.started()),
          child: const HomeView(),
        ),
      ),
      GoRoute(
        path: Routes.allApps,
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: BlocProvider(
            create: (_) =>
                getIt<AllAppsBloc>()..add(const AllAppsEvent.started()),
            child: const AllAppsView(),
          ),
        ),
      ),
      GoRoute(
        path: Routes.settings,
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: Theme(
            data: Win95Theme.themeData(),
            child: BlocProvider(
              create: (_) =>
                  getIt<SettingsBloc>()..add(const SettingsEvent.started()),
              child: const SettingsView(),
            ),
          ),
        ),
        routes: [
          GoRoute(
            path: 'appearance',
            pageBuilder: (context, state) => NoTransitionPage<void>(
              key: state.pageKey,
              child: Theme(
                data: Win95Theme.themeData(),
                child: BlocProvider(
                  create: (_) => getIt<AppearanceSettingsBloc>()
                    ..add(const AppearanceSettingsEvent.started()),
                  child: const AppearanceSettingsView(),
                ),
              ),
            ),
          ),
          GoRoute(
            path: 'permissions',
            pageBuilder: (context, state) => NoTransitionPage<void>(
              key: state.pageKey,
              child: Theme(
                data: Win95Theme.themeData(),
                child: BlocProvider(
                  create: (_) => getIt<PermissionsSettingsBloc>()
                    ..add(const PermissionsSettingsEvent.started()),
                  child: const PermissionsSettingsView(),
                ),
              ),
            ),
          ),
          GoRoute(
            path: 'favorites',
            pageBuilder: (context, state) => NoTransitionPage<void>(
              key: state.pageKey,
              child: Theme(
                data: Win95Theme.themeData(),
                child: BlocProvider(
                  create: (_) => getIt<FavoritesSettingsBloc>()
                    ..add(const FavoritesSettingsEvent.started()),
                  child: const FavoritesSettingsView(),
                ),
              ),
            ),
          ),
          GoRoute(
            path: 'preferred-apps',
            pageBuilder: (context, state) => NoTransitionPage<void>(
              key: state.pageKey,
              child: Theme(
                data: Win95Theme.themeData(),
                child: BlocProvider(
                  create: (_) => getIt<PreferredAppsSettingsBloc>()
                    ..add(const PreferredAppsSettingsEvent.started()),
                  child: const PreferredAppsSettingsView(),
                ),
              ),
            ),
          ),
          GoRoute(
            path: 'restricted-apps',
            pageBuilder: (context, state) => NoTransitionPage<void>(
              key: state.pageKey,
              child: Theme(
                data: Win95Theme.themeData(),
                child: BlocProvider(
                  create: (_) => getIt<RestrictedAppsSettingsBloc>()
                    ..add(const RestrictedAppsSettingsEvent.started()),
                  child: const RestrictedAppsSettingsView(),
                ),
              ),
            ),
          ),
        ],
      ),
    ],
  );
}
