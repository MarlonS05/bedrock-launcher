import 'package:bedrock_launcher/db/app_database.dart';
import 'package:bedrock_launcher/domain/repositories/appearance_preferences_repository.dart';
import 'package:bedrock_launcher/domain/repositories/favorite_app_repository.dart';
import 'package:bedrock_launcher/domain/repositories/installed_apps_repository.dart';
import 'package:bedrock_launcher/domain/repositories/preferred_apps_preferences_repository.dart';
import 'package:bedrock_launcher/domain/repositories/restricted_app_repository.dart';
import 'package:bedrock_launcher/domain/services/battery_port.dart';
import 'package:bedrock_launcher/domain/services/default_browser_port.dart';
import 'package:bedrock_launcher/domain/services/installed_fonts_port.dart';
import 'package:bedrock_launcher/domain/services/system_apps_port.dart';
import 'package:bedrock_launcher/domain/services/installed_apps_port.dart';
import 'package:bedrock_launcher/domain/use_cases/add_favorite_app_use_case.dart';
import 'package:bedrock_launcher/domain/use_cases/get_appearance_preferences_use_case.dart';
import 'package:bedrock_launcher/domain/use_cases/get_battery_level_use_case.dart';
import 'package:bedrock_launcher/domain/use_cases/get_favorite_apps_use_case.dart';
import 'package:bedrock_launcher/domain/use_cases/get_preferred_apps_preferences_use_case.dart';
import 'package:bedrock_launcher/domain/use_cases/get_restricted_apps_use_case.dart';
import 'package:bedrock_launcher/domain/use_cases/launch_app_use_case.dart';
import 'package:bedrock_launcher/domain/use_cases/list_installed_apps_use_case.dart';
import 'package:bedrock_launcher/domain/use_cases/load_launcher_apps_use_case.dart';
import 'package:bedrock_launcher/domain/use_cases/remove_favorite_app_use_case.dart';
import 'package:bedrock_launcher/domain/use_cases/reorder_favorite_apps_use_case.dart';
import 'package:bedrock_launcher/domain/use_cases/replace_restricted_apps_use_case.dart';
import 'package:bedrock_launcher/domain/use_cases/set_appearance_preferences_use_case.dart';
import 'package:bedrock_launcher/domain/use_cases/set_preferred_apps_preferences_use_case.dart';
import 'package:bedrock_launcher/domain/use_cases/set_text_color_use_case.dart';
import 'package:bedrock_launcher/domain/use_cases/set_theme_color_use_case.dart';
import 'package:bedrock_launcher/domain/services/launcher_settings_port.dart';
import 'package:bedrock_launcher/domain/use_cases/open_app_settings_use_case.dart';
import 'package:bedrock_launcher/domain/use_cases/open_camera_use_case.dart';
import 'package:bedrock_launcher/domain/use_cases/open_gallery_use_case.dart';
import 'package:bedrock_launcher/domain/use_cases/open_clock_use_case.dart';
import 'package:bedrock_launcher/domain/use_cases/open_default_browser_use_case.dart';
import 'package:bedrock_launcher/domain/use_cases/open_dialer_use_case.dart';
import 'package:bedrock_launcher/domain/use_cases/open_default_launcher_settings_use_case.dart';
import 'package:bedrock_launcher/domain/use_cases/prune_uninstalled_favorite_apps_use_case.dart';
import 'package:bedrock_launcher/domain/use_cases/uninstall_app_use_case.dart';
import 'package:bedrock_launcher/platform/android_battery_adapter.dart';
import 'package:bedrock_launcher/platform/android_default_browser_adapter.dart';
import 'package:bedrock_launcher/platform/android_installed_fonts_adapter.dart';
import 'package:bedrock_launcher/platform/android_system_apps_adapter.dart';
import 'package:bedrock_launcher/platform/android_installed_apps_adapter.dart';
import 'package:bedrock_launcher/platform/android_launcher_settings_adapter.dart';
import 'package:bedrock_launcher/repo/appearance_preferences_repository_impl.dart';
import 'package:bedrock_launcher/repo/favorite_app_repository_impl.dart';
import 'package:bedrock_launcher/repo/installed_apps_repository_impl.dart';
import 'package:bedrock_launcher/repo/preferred_apps_preferences_repository_impl.dart';
import 'package:bedrock_launcher/repo/restricted_app_repository_impl.dart';
import 'package:bedrock_launcher/router/app_router.dart';
import 'package:bedrock_launcher/screens/all_apps/all_apps_bloc.dart';
import 'package:bedrock_launcher/screens/home/home_bloc.dart';
import 'package:bedrock_launcher/screens/settings/appearance/appearance_settings_bloc.dart';
import 'package:bedrock_launcher/screens/settings/favorites/favorites_settings_bloc.dart';
import 'package:bedrock_launcher/screens/settings/permissions/permissions_settings_bloc.dart';
import 'package:bedrock_launcher/screens/settings/preferred_apps/preferred_apps_settings_bloc.dart';
import 'package:bedrock_launcher/screens/settings/restricted_apps/restricted_apps_settings_bloc.dart';
import 'package:bedrock_launcher/screens/settings/settings_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:sqflite/sqflite.dart';

final getIt = GetIt.instance;

Future<void> configureDependencies({
  Future<Database> Function()? openDatabase,
}) async {
  getIt.registerLazySingleton<GoRouter>(createRouter);
  getIt.registerLazySingleton<AppRouter>(() => AppRouter(getIt()));

  final database = openDatabase != null
      ? await openDatabase()
      : await openAppDatabase();
  getIt.registerLazySingleton<FavoriteAppRepository>(
    () => FavoriteAppRepositoryImpl(database),
  );
  getIt.registerLazySingleton<AppearancePreferencesRepository>(
    () => AppearancePreferencesRepositoryImpl(database),
  );
  getIt.registerLazySingleton<PreferredAppsPreferencesRepository>(
    () => PreferredAppsPreferencesRepositoryImpl(database),
  );
  getIt.registerLazySingleton<RestrictedAppRepository>(
    () => RestrictedAppRepositoryImpl(database),
  );
  getIt.registerLazySingleton(() => AddFavoriteAppUseCase(getIt()));
  getIt.registerLazySingleton(() => RemoveFavoriteAppUseCase(getIt()));
  getIt.registerLazySingleton(() => ReorderFavoriteAppsUseCase(getIt()));
  getIt.registerLazySingleton(() => GetFavoriteAppsUseCase(getIt()));
  getIt.registerLazySingleton(
    () => PruneUninstalledFavoriteAppsUseCase(getIt(), getIt()),
  );
  getIt.registerLazySingleton(() => GetRestrictedAppsUseCase(getIt()));
  getIt.registerLazySingleton(() => ReplaceRestrictedAppsUseCase(getIt()));
  getIt.registerLazySingleton(() => GetAppearancePreferencesUseCase(getIt()));
  getIt.registerLazySingleton(() => SetThemeColorUseCase(getIt()));
  getIt.registerLazySingleton(() => SetTextColorUseCase(getIt()));
  getIt.registerLazySingleton(() => SetAppearancePreferencesUseCase(getIt()));
  getIt.registerLazySingleton(
    () => GetPreferredAppsPreferencesUseCase(getIt()),
  );
  getIt.registerLazySingleton(
    () => SetPreferredAppsPreferencesUseCase(getIt()),
  );
  getIt.registerLazySingleton<InstalledAppsPort>(
    AndroidInstalledAppsAdapter.new,
  );
  getIt.registerLazySingleton<InstalledAppsRepository>(
    () => InstalledAppsRepositoryImpl(getIt()),
  );
  getIt.registerLazySingleton<DefaultBrowserPort>(
    AndroidDefaultBrowserAdapter.new,
  );
  getIt.registerLazySingleton<SystemAppsPort>(
    AndroidSystemAppsAdapter.new,
  );
  getIt.registerLazySingleton<LauncherSettingsPort>(
    AndroidLauncherSettingsAdapter.new,
  );
  getIt.registerLazySingleton<BatteryPort>(AndroidBatteryAdapter.new);
  getIt.registerLazySingleton<InstalledFontsPort>(
    AndroidInstalledFontsAdapter.new,
  );
  getIt.registerLazySingleton(() => ListInstalledAppsUseCase(getIt()));
  getIt.registerLazySingleton(
    () => LoadLauncherAppsUseCase(getIt(), getIt(), getIt()),
  );
  getIt.registerLazySingleton(() => LaunchAppUseCase(getIt()));
  getIt.registerLazySingleton(() => OpenDefaultBrowserUseCase(getIt()));
  getIt.registerLazySingleton(
    () => OpenDialerUseCase(getIt(), getIt(), getIt()),
  );
  getIt.registerLazySingleton(
    () => OpenCameraUseCase(getIt(), getIt(), getIt()),
  );
  getIt.registerLazySingleton(
    () => OpenGalleryUseCase(getIt(), getIt(), getIt()),
  );
  getIt.registerLazySingleton(
    () => OpenClockUseCase(getIt(), getIt(), getIt()),
  );
  getIt.registerLazySingleton(() => OpenAppSettingsUseCase(getIt()));
  getIt.registerLazySingleton(() => UninstallAppUseCase(getIt(), getIt()));
  getIt.registerLazySingleton(() => OpenDefaultLauncherSettingsUseCase(getIt()));
  getIt.registerLazySingleton(() => GetBatteryLevelUseCase(getIt()));
  getIt.registerFactory(
    () => HomeBloc(
      appRouter: getIt(),
      getAppearancePreferencesUseCase: getIt(),
      getPreferredAppsPreferencesUseCase: getIt(),
      loadLauncherAppsUseCase: getIt(),
      getBatteryLevelUseCase: getIt(),
      launchAppUseCase: getIt(),
      openDefaultBrowserUseCase: getIt(),
      openDialerUseCase: getIt(),
      openCameraUseCase: getIt(),
      openGalleryUseCase: getIt(),
      openClockUseCase: getIt(),
      installedFontsPort: getIt(),
    ),
  );
  getIt.registerFactory(
    () => AllAppsBloc(
      appRouter: getIt(),
      getAppearancePreferencesUseCase: getIt(),
      loadLauncherAppsUseCase: getIt(),
      launchAppUseCase: getIt(),
      addFavoriteAppUseCase: getIt(),
      removeFavoriteAppUseCase: getIt(),
      uninstallAppUseCase: getIt(),
      openAppSettingsUseCase: getIt(),
      installedFontsPort: getIt(),
    ),
  );
  getIt.registerFactory(() => SettingsBloc(appRouter: getIt()));
  getIt.registerFactory(
    () => AppearanceSettingsBloc(
      appRouter: getIt(),
      getAppearancePreferencesUseCase: getIt(),
      setAppearancePreferencesUseCase: getIt(),
      installedFontsPort: getIt(),
    ),
  );
  getIt.registerFactory(
    () => FavoritesSettingsBloc(
      appRouter: getIt(),
      pruneUninstalledFavoriteAppsUseCase: getIt(),
      reorderFavoriteAppsUseCase: getIt(),
    ),
  );
  getIt.registerFactory(
    () => PermissionsSettingsBloc(
      appRouter: getIt(),
      openDefaultLauncherSettingsUseCase: getIt(),
    ),
  );
  getIt.registerFactory(
    () => PreferredAppsSettingsBloc(
      appRouter: getIt(),
      getPreferredAppsPreferencesUseCase: getIt(),
      setPreferredAppsPreferencesUseCase: getIt(),
      listInstalledAppsUseCase: getIt(),
    ),
  );
  getIt.registerFactory(
    () => RestrictedAppsSettingsBloc(
      appRouter: getIt(),
      getRestrictedAppsUseCase: getIt(),
      replaceRestrictedAppsUseCase: getIt(),
      listInstalledAppsUseCase: getIt(),
    ),
  );
}
