import 'package:bedrock_launcher/domain/entities/launcher_app.dart';
import 'package:bedrock_launcher/domain/repositories/installed_apps_repository.dart';

class ListInstalledAppsUseCase {
  const ListInstalledAppsUseCase(this._repository);

  final InstalledAppsRepository _repository;

  List<LauncherApp>? get cached => _repository.cached;

  Future<List<LauncherApp>> call({bool forceRefresh = false}) =>
      _repository.getInstalledApps(forceRefresh: forceRefresh);
}
