import 'package:bedrock_launcher/domain/entities/favorite_app.dart';
import 'package:bedrock_launcher/domain/repositories/favorite_app_repository.dart';
import 'package:bedrock_launcher/domain/use_cases/list_installed_apps_use_case.dart';

class PruneUninstalledFavoriteAppsUseCase {
  const PruneUninstalledFavoriteAppsUseCase(
    this._repository,
    this._listInstalledAppsUseCase,
  );

  final FavoriteAppRepository _repository;
  final ListInstalledAppsUseCase _listInstalledAppsUseCase;

  /// Removes favorites whose apps are no longer installed.
  ///
  /// Returns the remaining favorites sorted by display order ascending.
  Future<List<FavoriteApp>> call() async {
    final installedPackageNames = {
      for (final app in await _listInstalledAppsUseCase(forceRefresh: true))
        app.packageName,
    };
    final favorites = await _repository.getAll();

    for (final favorite in favorites) {
      if (!installedPackageNames.contains(favorite.packageName)) {
        await _repository.remove(favorite.packageName);
      }
    }

    return _repository.getAll();
  }
}
