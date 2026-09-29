import 'package:bedrock_launcher/domain/repositories/restricted_app_repository.dart';

class ReplaceRestrictedAppsUseCase {
  const ReplaceRestrictedAppsUseCase(this._repository);

  final RestrictedAppRepository _repository;

  Future<void> call(Set<String> packageNames) {
    return _repository.replaceAll(packageNames);
  }
}
