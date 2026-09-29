import 'package:bedrock_launcher/domain/entities/favorite_app.dart';
import 'package:bedrock_launcher/domain/entities/launcher_app.dart';
import 'package:bedrock_launcher/domain/entities/restricted_app.dart';

class LauncherAppsSnapshot {
  const LauncherAppsSnapshot({
    required this.installedApps,
    required this.favorites,
    required this.restrictedApps,
  });

  final List<LauncherApp> installedApps;
  final List<FavoriteApp> favorites;
  final List<RestrictedApp> restrictedApps;

  Set<String> get favoritePackageNames => {
        for (final favorite in favorites) favorite.packageName,
      };

  Set<String> get restrictedPackageNames => {
        for (final restricted in restrictedApps) restricted.packageName,
      };

  /// Favorites resolved to installed apps, in favorite display order.
  List<LauncherApp> get favoriteApps {
    final appsByPackageName = {
      for (final app in installedApps) app.packageName: app,
    };

    return [
      for (final favorite in favorites)
        if (appsByPackageName.containsKey(favorite.packageName))
          appsByPackageName[favorite.packageName]!,
    ];
  }
}
