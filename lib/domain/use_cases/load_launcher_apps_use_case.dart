import 'package:bedrock_launcher/domain/entities/favorite_app.dart';
import 'package:bedrock_launcher/domain/entities/launcher_app.dart';
import 'package:bedrock_launcher/domain/entities/launcher_apps_snapshot.dart';
import 'package:bedrock_launcher/domain/entities/restricted_app.dart';
import 'package:bedrock_launcher/domain/use_cases/get_favorite_apps_use_case.dart';
import 'package:bedrock_launcher/domain/use_cases/get_restricted_apps_use_case.dart';
import 'package:bedrock_launcher/domain/use_cases/list_installed_apps_use_case.dart';

class LoadLauncherAppsUseCase {
  const LoadLauncherAppsUseCase(
    this._listInstalledAppsUseCase,
    this._getFavoriteAppsUseCase,
    this._getRestrictedAppsUseCase,
  );

  final ListInstalledAppsUseCase _listInstalledAppsUseCase;
  final GetFavoriteAppsUseCase _getFavoriteAppsUseCase;
  final GetRestrictedAppsUseCase _getRestrictedAppsUseCase;

  /// Loads installed apps, favorites, and restricted apps together.
  ///
  /// When [forceRefresh] is true, the installed-apps cache is bypassed and
  /// refilled from the platform.
  Future<LauncherAppsSnapshot> call({bool forceRefresh = false}) async {
    final results = await Future.wait([
      _listInstalledAppsUseCase(forceRefresh: forceRefresh),
      _getFavoriteAppsUseCase(),
      _getRestrictedAppsUseCase(),
    ]);

    final installedApps = results[0] as List<LauncherApp>;
    final favorites = results[1] as List<FavoriteApp>;
    final restrictedApps = results[2] as List<RestrictedApp>;
    final restrictedNames = {
      for (final restricted in restrictedApps) restricted.packageName,
    };

    return LauncherAppsSnapshot(
      installedApps: [
        for (final app in installedApps)
          LauncherApp(
            packageName: app.packageName,
            displayName: app.displayName,
            isRestricted: restrictedNames.contains(app.packageName),
          ),
      ],
      favorites: favorites,
      restrictedApps: restrictedApps,
    );
  }
}
