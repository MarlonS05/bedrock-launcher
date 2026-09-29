import 'package:bedrock_launcher/domain/repositories/favorite_app_repository.dart';

class RemoveFavoriteAppUseCase {
  const RemoveFavoriteAppUseCase(this._repository);

  final FavoriteAppRepository _repository;

  Future<void> call(String packageName) {
    return _repository.remove(packageName);
  }
}
