import 'package:bedrock_launcher/domain/entities/restricted_app.dart';
import 'package:bedrock_launcher/domain/repositories/restricted_app_repository.dart';

class GetRestrictedAppsUseCase {
  const GetRestrictedAppsUseCase(this._repository);

  final RestrictedAppRepository _repository;

  Future<List<RestrictedApp>> call() => _repository.getAll();
}
