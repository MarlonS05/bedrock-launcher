import 'package:bedrock_launcher/domain/repositories/favorite_app_repository.dart';

class ReorderFavoriteAppsUseCase {
  const ReorderFavoriteAppsUseCase(this._repository);

  final FavoriteAppRepository _repository;

  Future<void> call(List<String> packageNamesInOrder) {
    return _repository.reorder(packageNamesInOrder);
  }
}
